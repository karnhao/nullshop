import 'package:nullshop/models/user_model.dart';
import 'package:nullshop/services/auth_service.dart';
import 'package:nullshop/services/database_service_interface.dart';
import 'package:nullshop/themes/colors.dart';
import 'package:nullshop/utils/show_snack_bar.dart';
import 'package:nullshop/widgets/coin_btn_widget.dart';
import 'package:nullshop/widgets/main_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  int withdrawValue = 0;
  List<int> amountList = [100, 300, 500, 700, 1000, 2000];
  User? user;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.getCurrentUser().then((t) {
      user = t;
    });
    return Scaffold(
      backgroundColor: kColorsCream,
      appBar: AppBar(
        title: Text('Withdraw', style: Theme.of(context).textTheme.headline3),
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
                Navigator.pushNamed(context, '/profile');
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
          withdraw(),
          Positioned(top: 325, child: inputAmount()),
          Positioned(
              bottom: 20,
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Withdraw"),
                            content: Text("Withdraw $withdrawValue coin."),
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, "Cancel");
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    user!.coin = user!.coin! - withdrawValue;
                                    final databaseService =
                                        Provider.of<DatabaseServiceInterface>(
                                            context,
                                            listen: false);
                                    databaseService
                                        .updateUserFromUid(
                                            uid: user!.uid, user: user!)
                                        .then((t) {
                                      showSnackBar("Success",
                                          backgroundColor: Colors.green);
                                    }).catchError((e) {
                                      showSnackBar("Failed $e");
                                    });
                                    Navigator.pop(context, "Finish");
                                  },
                                  child: const Text("Confirm")),
                            ],
                          ));
                },
                child: const MainBtnWidget(
                    colorBtn: kColorsRed,
                    textBtn: 'Withdraw',
                    isTransparent: true,
                    haveIcon: false),
              ))
        ],
      ),
    );
  }

  // Create Withdraw Menu
  Widget withdraw() {
    return Stack(
      children: [
        SizedBox(
          height: 325,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          height: 180,
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
              color: kColorsPurple),
        ),
        Positioned(
          top: 50,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Container(
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                    Text('Withdraw value',
                        style: Theme.of(context).textTheme.headline4),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(color: kColorsCream),
                      ),
                    ),
                    SizedBox(
                      height: 130,
                      child: Center(
                        child: Wrap(
                          runSpacing: 10.0,
                          spacing: 30.0,
                          children: [
                            ...List.generate(
                                amountList.length,
                                (index) => InkWell(
                                      onTap: () {
                                        setState(() {
                                          withdrawValue = amountList[index];
                                        });
                                      },
                                      child: CoinBtnWidget(
                                        textBtn: '${amountList[index]}',
                                      ),
                                    ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // Create input Amount Tab
  Widget inputAmount() {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: kColorsWhite,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Input Amount',
                  style: Theme.of(context).textTheme.headline4),
              Text(
                '\$ $withdrawValue',
                style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: kColorsRed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
