import 'package:nullshop/models/transaction_model.dart';
import 'package:nullshop/models/user_model.dart';
import 'package:nullshop/services/auth_service.dart';
import 'package:nullshop/services/transaction_service_interface.dart';
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
  List<TransactionObject> transactions = [];
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);

    if (!flag) {
      authService.getCurrentUser().then((value) {
        user = value;
        final transactionService =
            Provider.of<TransactionServiceInterface>(context, listen: false);
        transactionService.get(user!.uid).then((value) {
          setState(() {
            value.items
                .sort(((a, b) => b.timeMillis!.compareTo(a.timeMillis!)));
            transactions = value.items;
            flag = true;
          });
        });
      });
    }

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
                          height: 2,
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
                            itemCount: transactions.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 9, horizontal: 7),
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: kColorsCream,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Product Time
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              transactions[index].time ?? "",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: kColorsGrey),
                                            ),
                                            //Quantity Product
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Text(
                                                "x${transactions[index].productCount}",
                                                style: const TextStyle(
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: kColorsGrey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Name Product
                                        Text(
                                          transactions[index].productName,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: kColorsPurple),
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                        ),
                                        //Price Product
                                        Text(
                                          "\$ ${transactions[index].productPrice > 0 ? '-' : '+'}${(transactions[index].productPrice * transactions[index].productCount).abs().toString()}",
                                          style: TextStyle(
                                              letterSpacing: 0.7,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: transactions[index]
                                                          .productPrice >
                                                      0
                                                  ? kColorsRed
                                                  : Colors.green),
                                        )
                                      ],
                                    ),
                                  ),
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
