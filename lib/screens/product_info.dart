import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nullshop/models/product_model.dart';
import 'package:nullshop/themes/colors.dart';
import 'package:nullshop/utils/show_snack_bar.dart';
import 'package:nullshop/widgets/main_btn.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Product Info",
            style: Theme.of(context).textTheme.headline3,
          ),
          shape:
              const Border(bottom: BorderSide(color: kColorsGrey, width: 1.5)),
          elevation: 0,
          toolbarHeight: 60,
          backgroundColor: kColorsPurple,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/add-product");
                },
                icon: SvgPicture.asset(
                  "assets/icons/add.svg",
                  color: kColorsWhite,
                )),
            IconButton(
                onPressed: null,
                icon: SvgPicture.asset(
                  "assets/icons/msg.svg",
                  color: kColorsWhite,
                )),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                icon: SvgPicture.asset(
                  "assets/icons/me.svg",
                  color: kColorsWhite,
                ))
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
              InkWell(
                onTap: () {
                  showSnackBar(
                      "Database Service not available. Please wait for future updates.");
                },
                child: const MainBtnWidget(
                    colorBtn: Colors.green,
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
}
