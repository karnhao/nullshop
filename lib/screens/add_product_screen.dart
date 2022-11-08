import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nullshop/themes/colors.dart';
import 'package:nullshop/widgets/input_decoration.dart';
import 'package:nullshop/widgets/main_btn.dart';

class AddProdectScreen extends StatefulWidget {
  const AddProdectScreen({super.key});

  @override
  State<AddProdectScreen> createState() => _AddProdectScreenState();
}

class _AddProdectScreenState extends State<AddProdectScreen> {
  final formKey = GlobalKey<FormState>();
  String? productCategory = "Pen",
      productName,
      productPrice,
      productQuantity,
      productDescription,
      product;

  @override
  Widget build(BuildContext context) {
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
          'Add Product',
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
          IconButton(
              onPressed: () {},
              icon:
                  SvgPicture.asset("assets/icons/me.svg", color: kColorsCream))
        ],
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                }
              },
              child: MainBtnWidget(
                colorBtn: kColorsPurple,
                textBtn: "Confirm",
                haveIcon: false,
                isTransparent: false,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget createProductName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: TextFormField(
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
    List<String> category = [
      'Pen',
      'Book',
      'Paper',
      'Eraser',
      'Marker',
      'Folder'
    ];
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
}
