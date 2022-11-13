import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nullshop/models/product_model.dart';
import 'package:nullshop/services/database_service_interface.dart';
import 'package:nullshop/themes/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final databaseService =
        Provider.of<DatabaseServiceInterface>(context, listen: false);
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
                  ...[
                    "All Items",
                    ...ProductCategory.values.map((t) => t.name.toString())
                  ].map(
                    (u) => SizedBox(
                      width: 100,
                      child: Center(
                        child: Text(u,
                            style: Theme.of(context).textTheme.subtitle1),
                      ),
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
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
                icon: SvgPicture.asset("assets/icons/me.svg"))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: FutureBuilder<List<Product?>>(
              future: databaseService.getFutureListProduct(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log("${snapshot.error}");
                  return Text("Failed to get product ${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Text("No data");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading...");
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 13 / 20),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final imageUrl = snapshot.data?[index]?.photoURL;
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/product-info",
                                  arguments: snapshot.data?[index])
                              .then((value) {
                            if (value == true) {
                              setState(() {});
                            }
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: imageUrl == null || imageUrl == ""
                                  ? Container(
                                      decoration: const BoxDecoration(
                                          color: kColorsRed,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child:
                                          const Center(child: Text("No Image")),
                                    )
                                  : ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/placeholderimage.png",
                                        image: imageUrl,
                                        fit: BoxFit.cover,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
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
                                      )),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              snapshot.data![index]!.name,
                              style: Theme.of(context).textTheme.subtitle1,
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                                "\$ ${snapshot.data![index]!.price.toString()}",
                                style: const TextStyle(
                                    letterSpacing: 0.7,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: kColorsRed),
                                maxLines: 1),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}

class SubTitle extends Container {
  SubTitle({super.key});
}
