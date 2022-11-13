import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nullshop/models/product_model.dart';
import 'package:nullshop/models/transaction_model.dart';
import 'package:nullshop/services/auth_service.dart';
import 'package:nullshop/services/database_service_interface.dart';
import 'package:nullshop/services/transaction_service_interface.dart';
import 'package:nullshop/themes/colors.dart';
import 'package:nullshop/utils/date_time_format.dart';
import 'package:nullshop/utils/show_snack_bar.dart';
import 'package:nullshop/widgets/main_btn.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int amount = 0;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Product Info",
            style: Theme.of(context).textTheme.headline3,
          ),
          shape:
              const Border(bottom: BorderSide(color: kColorsGrey, width: 0.5)),
          elevation: 0,
          toolbarHeight: 60,
          backgroundColor: kColorsPurple,
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/back.svg",
              color: kColorsWhite,
            ),
            onPressed: () {
              Navigator.pop(context, "/home");
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  removeHandle(product);
                },
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined, color: Colors.white)),
          ]),
      body: ListView(children: [
        AspectRatio(
          aspectRatio: 1,
          child: product.photoURL == "" || product.photoURL == null
              ? Container(
                  decoration: const BoxDecoration(color: kColorsCream),
                  child: Center(
                      child: Text("NO IMAGE",
                          style: Theme.of(context).textTheme.headline1)),
                )
              : Image.network(
                  product.photoURL!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: kColorsRed,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Center(
                        child: Text(
                            "Image not available! Maybe max quota of firebase. Please report this to administrator."),
                      ),
                    ),
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(product.category?.name ?? "UNKNOWN!",
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 20),
              Text(product.name, style: Theme.of(context).textTheme.headline2),
              const SizedBox(height: 20),
              Text("\$ ${product.price}",
                  style: const TextStyle(
                      color: kColorsRed,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              Text("Quantity: ${product.quantity}",
                  style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 20),
              Text(product.description ?? "",
                  style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                      shape: const CircleBorder(),
                      onPressed: () {
                        removeAmountValue();
                      },
                      child: const Icon(
                        Icons.remove,
                        color: Colors.red,
                      )),
                  Text("$amount",
                      style: const TextStyle(
                          color: kColorsPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  RawMaterialButton(
                      shape: const CircleBorder(),
                      onPressed: () {
                        addAmountValue();
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.green,
                      )),
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    try {
                      if (amount <= 0) return;
                      buyHandle(product);
                    } catch (e) {
                      showSnackBar('$e');
                    }
                  });
                },
                child: MainBtnWidget(
                    colorBtn: (amount > 0) ? Colors.green : Colors.grey,
                    textBtn: "Buy",
                    isTransparent: false,
                    haveIcon: false),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        )
      ]),
    );
  }

  void addAmountValue() {
    //ฝากเช็คหน่อยว่ามันเกินจำนวนที่อยู่ใน Database ไหม
    Product product = ModalRoute.of(context)?.settings.arguments as Product;

    if (amount >= product.quantity) return;
    setState(() {
      amount++;
    });
  }

  void removeAmountValue() {
    if (amount <= 0) return;

    setState(() {
      amount--;
    });
  }

  void buyHandle(Product product) {
    try {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Buy"),
                content: Text(
                    "Buy $amount ${product.name}? It will cost ${amount * product.price} \$"),
                actionsAlignment: MainAxisAlignment.spaceAround,
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, "Cancel");
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        buy(product).then((v) {
                          product = Product(
                              name: product.name,
                              price: product.price,
                              quantity: product.quantity - amount,
                              category: product.category,
                              description: product.description,
                              photoURL: product.photoURL,
                              uid: product.uid);
                          Navigator.pop(context, "Finish");
                          showSnackBar('Buy successful!',
                              backgroundColor: Colors.green);
                          Navigator.pop(context, true);
                        }).catchError((e) {
                          Navigator.pop(context);
                          showSnackBar('$e');
                        });
                      },
                      child: const Text("Confirm")),
                ],
              ));
    } catch (e) {
      showSnackBar('$e');
    }
  }

  Future<void> buy(Product product) async {
    final databaseService =
        Provider.of<DatabaseServiceInterface>(context, listen: false);
    final transactionService =
        Provider.of<TransactionServiceInterface>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    final date = DateTime.now().toLocal();
    String time = dateTimeFormat(date);

    final user = await authService.getCurrentUser();
    await databaseService.buyProduct(
        userUid: user!.uid, productUid: product.uid!, buyAmount: amount);

    TransactionCollection tc = await transactionService.get(user.uid);
    tc.items.add(TransactionObject(
        productName: product.name,
        productPrice: product.price,
        productCount: amount,
        collectionUID: user.uid,
        time: time,
        timeMillis: date.millisecondsSinceEpoch));
    await transactionService.update(user.uid, tc);
  }

  Future<void> removeHandle(Product product) async {
    try {
      final databaseService =
          Provider.of<DatabaseServiceInterface>(context, listen: false);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Remove"),
                content: Text(
                    "Are you sure to remove ${product.name} from shoping? It will lost forever."),
                actionsAlignment: MainAxisAlignment.spaceAround,
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, "Cancel");
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        databaseService
                            .removeProduct(uid: product.uid!)
                            .then((v) {
                          Navigator.pop(context, "Finish");
                          showSnackBar('Remove successful!',
                              backgroundColor: Colors.green);
                          Navigator.pop(context, true);
                        }).catchError((e) {
                          Navigator.pop(context);
                          showSnackBar('$e');
                        });
                      },
                      child: const Text("Delete",
                          style: TextStyle(color: Colors.red))),
                ],
              ));
    } catch (e) {
      showSnackBar('$e');
    }
  }
}
