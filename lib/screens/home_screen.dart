import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nullshop/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/msg.svg")),
            IconButton(
                onPressed: () {}, icon: SvgPicture.asset("assets/icons/me.svg"))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 13 / 20),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/product-info");
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: kColorsRed,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child:
                              const Center(child: Text("Product Image Here!")),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("Product name",
                          style: Theme.of(context).textTheme.subtitle1),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text("\$ price",
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class SubTitle extends Container {
  SubTitle({super.key});
}
