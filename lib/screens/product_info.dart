import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nullshop/themes/colors.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
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
                onPressed: null,
                icon: SvgPicture.asset(
                  "assets/icons/me.svg",
                  color: kColorsWhite,
                ))
          ]),
      body: ListView(children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: const BoxDecoration(color: kColorsCream),
            child: Center(
                child: Text("IMAGE",
                    style: Theme.of(context).textTheme.headline1)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text("Book", style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 20),
              Text("Product name",
                  style: Theme.of(context).textTheme.headline2),
              const SizedBox(height: 20),
              const Text("\$ Price",
                  style: TextStyle(
                      color: kColorsRed,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              Text("Quantity: 2", style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 20),
              Text(
                  "Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  style: Theme.of(context).textTheme.subtitle1)
            ],
          ),
        )
      ]),
    );
  }
}
