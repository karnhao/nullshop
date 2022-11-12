import 'package:nullshop/models/user_model.dart';
import 'package:nullshop/services/auth_service.dart';
import 'package:nullshop/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nullshop/utils/show_snack_bar.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  User? user;
  List<int> items = [1, 2, 3, 4, 5, 6, 4, 7, 5, 9, 5, 5, 8, 4, 2, 56, 98];

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);

    authService.getCurrentUser().then((value) {
      user = value;
    });
    return Scaffold(
      backgroundColor: kColorsCream,
      appBar: AppBar(
        title:
            Text('Transaction', style: Theme.of(context).textTheme.headline3),
        backgroundColor: kColorsPurple,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back.svg', color: kColorsWhite),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/msg.svg',
                  color: kColorsWhite)),
          IconButton(
              onPressed: () {
                if (user != null) {
                  showSnackBar(user?.username ?? "Loading please wait...");
                }
              },
              icon:
                  SvgPicture.asset('assets/icons/me.svg', color: kColorsWhite))
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
                color: kColorsPurple),
          ),
          Positioned(
            top: 50,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: kColorsWhite,
                        boxShadow: [
                          BoxShadow(
                            color: kColorsBlack.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Latest Transactions',
                          style: Theme.of(context).textTheme.headline4),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: 1.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(color: kColorsCream),
                        ),
                      ),
                      // TO DO: Create transaction
                      Container(
                        decoration: BoxDecoration(
                            color: kColorsWhite,
                            borderRadius: BorderRadius.circular(15)),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.67,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: items.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //image
                                    Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.purple,
                                      // child: const Text("Hell"),
                                    ),
                                    //name
                                    Container(
                                      child: const Text(
                                        "Name",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: kColorsPurple),
                                      ),
                                    ),
                                    //Quantity
                                    Container(
                                      child: const Text(
                                        "Quantity",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: kColorsPurple),
                                      ),
                                    ),
                                    //Price
                                    Container(
                                      child: const Text(
                                        "Price",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: kColorsPurple),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
