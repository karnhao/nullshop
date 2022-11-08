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
        backgroundColor: Colors.white,
        title: Text(
          'Fakebook',
          style: Theme.of(context).textTheme.headline2,
        ),
        shape:
            const Border(bottom: BorderSide(color: kColorsCream, width: 1.5)),
        elevation: 0,
        toolbarHeight: 60,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text("Books",
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text("Guns",
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text("Bombs",
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text("Nukes",
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text("Death Star",
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/add-product");
              },
              icon: SvgPicture.asset("assets/icons/add.svg")),
          IconButton(
              onPressed: () {}, icon: SvgPicture.asset("assets/icons/msg.svg")),
          IconButton(
              onPressed: () {}, icon: SvgPicture.asset("assets/icons/me.svg"))
        ],
      ),
    );
  }
}
