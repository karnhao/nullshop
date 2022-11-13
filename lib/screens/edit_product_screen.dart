import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nullshop/models/product_model.dart';
import 'package:nullshop/services/database_service_interface.dart';
import 'package:nullshop/services/storage_service.dart';
import 'package:nullshop/themes/colors.dart';
import 'package:nullshop/utils/show_snack_bar.dart';
import 'package:nullshop/widgets/input_decoration.dart';
import 'package:nullshop/widgets/main_btn.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  File? imageFile;
  final picker = ImagePicker();

  final formKey = GlobalKey<FormState>();
  String? productCategory = "pen",
      productName,
      productPrice,
      productQuantity,
      productDescription;

  Product? product;

  @override
  Widget build(BuildContext context) {
    log("Test");
    product = ModalRoute.of(context)?.settings.arguments as Product;
    productCategory = product!.category.toString();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon:
                SvgPicture.asset("assets/icons/back.svg", color: kColorsWhite),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: kColorsPurple,
        title: Text(
          'Edit Product',
          style: Theme.of(context).textTheme.headline3,
        ),
        shape:
            const Border(bottom: BorderSide(color: kColorsCream, width: 1.5)),
        elevation: 0,
        toolbarHeight: 60,
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/msg.svg",
                  color: kColorsCream)),
        ],
      ),
      body: InkWell(
        onTap: (() {
          FocusScope.of(context).unfocus();
        }),
        hoverColor: Colors.white,
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createProductCategory(),
                      createProductName(),
                      createProductPrice(),
                      createProductQuantity(),
                      createProductDescription()
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                  onTap: () {
                    confirmHandle(context: context);
                  },
                  child: const MainBtnWidget(
                    colorBtn: kColorsPurple,
                    textBtn: "Confirm",
                    haveIcon: false,
                    isTransparent: false,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget createProductName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: TextFormField(
          initialValue: product!.name,
          keyboardType: TextInputType.text,
          autofocus: false,
          style: Theme.of(context).textTheme.subtitle1,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter product name";
            } else {
              return null;
            }
          },
          onChanged: ((value) {
            productName = value;
          }),
          decoration: inputDecorationWidget(context, "Name")),
    );
  }

  Widget createProductPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: TextFormField(
          initialValue: product!.price.toInt().toString(),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          autofocus: false,
          style: Theme.of(context).textTheme.subtitle1,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter product price";
            } else {
              return null;
            }
          },
          onChanged: ((value) {
            productPrice = value;
          }),
          decoration: inputDecorationWidget(context, "Price")),
    );
  }

  Widget createProductQuantity() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: TextFormField(
          initialValue: product!.quantity.toString(),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          autofocus: false,
          style: Theme.of(context).textTheme.subtitle1,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter product Quantity";
            } else {
              return null;
            }
          },
          onChanged: ((value) {
            productQuantity = value;
          }),
          decoration: inputDecorationWidget(context, "Quantity")),
    );
  }

  Widget createProductDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: TextFormField(
          initialValue: product!.description,
          keyboardType: TextInputType.text,
          autofocus: false,
          style: Theme.of(context).textTheme.subtitle1,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter product Description";
            }
            return null;
          },
          onChanged: ((value) {
            productDescription = value;
          }),
          decoration: inputDecorationWidget(context, "Description")),
    );
  }

  Widget createProductCategory() {
    List<String> category =
        ProductCategory.values.map((t) => t.name.toString()).toList();
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: InputDecorator(
          decoration: InputDecoration(
              label: const Text("Categories"),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: kColorsGrey, width: 1),
              ),
              errorStyle: Theme.of(context).textTheme.bodyText2),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                value: productCategory,
                icon: SvgPicture.asset('assets/icons/down.svg',
                    color: kColorsGrey),
                elevation: 3,
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: kColorsPurple),
                items: category.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    productCategory = value.toString();
                  });
                }),
          ),
        ));
  }

  Future<void> confirmHandle({required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(strokeWidth: 4),
            ));
    final databaseService =
        Provider.of<DatabaseServiceInterface>(context, listen: false);

    final storageService = Provider.of<StorageService>(context, listen: false);

    if (!formKey.currentState!.validate()) {
      Navigator.pop(context);
      showSnackBar("Data not founded", backgroundColor: Colors.red);
      return;
    }
    formKey.currentState!.save();

    String? url;

    if (imageFile != null) {
      url = await storageService.uploadProductImage(imageFile: imageFile!);
    }
    final product = Product(
        name: productName!,
        price: double.parse(productPrice!),
        quantity: int.parse(productQuantity!),
        category: Product.getProductCategory(productCategory!),
        description: productDescription,
        photoURL: url);

    try {
      await databaseService.addProduct(product: product);
    } catch (e) {
      log(e.toString());
      showSnackBar("An error has occurred - ${e.toString()}");
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    showSnackBar("Add product successful", backgroundColor: Colors.green);
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
