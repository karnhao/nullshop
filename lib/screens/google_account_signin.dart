import 'package:nullshop/themes/colors.dart';
import 'package:nullshop/widgets/input_decoration.dart';
import 'package:nullshop/widgets/main_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleAccountSignIn extends StatefulWidget {
  const GoogleAccountSignIn({super.key});

  @override
  State<GoogleAccountSignIn> createState() => _GoogleAccountSignInState();
}

class _GoogleAccountSignInState extends State<GoogleAccountSignIn> {
  final formKey = GlobalKey<FormState>();
  String? phone, address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorsPurple,
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage("assets/bg.jpg"),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back.svg', color: kColorsWhite),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: kColorsWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 40, bottom: 20),
              child: Text('Register',
                  style: Theme.of(context).textTheme.headline1),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  createPhone(),
                  createAddress(),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: InkWell(
                    onTap: () {
                      registerHandle(context: context);
                    },
                    child: const MainBtnWidget(
                        colorBtn: kColorsPurple,
                        textBtn: 'Sign Up',
                        isTransparent: false,
                        haveIcon: false))),
          ]),
        ),
      ),
    );
  }

  Widget createPhone() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          autofocus: false,
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: inputDecorationWidget(context, 'Phone'),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter phone";
            }
            return null;
          },
          onChanged: (value) {
            phone = value;
          },
        ));
  }

  Widget createAddress() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: inputDecorationWidget(context, 'Address'),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter Address";
            }
            return null;
          },
          onChanged: (value) {
            address = value;
          },
        ));
  }

  Future<void> registerHandle({required BuildContext context}) async {}
}
