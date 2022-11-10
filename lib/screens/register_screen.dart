import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:nullshop/services/auth_sesrvice.dart';
import 'package:nullshop/themes/colors.dart';
import 'package:nullshop/utils/show_snack_bar.dart';
import 'package:nullshop/widgets/input_decoration.dart';
import 'package:nullshop/widgets/main_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  String? username, email, phone, password, confirmPassword, address;

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
                  createUsername(),
                  createEmail(),
                  createPhone(),
                  createAddress(),
                  createPassword(),
                  createConfirmPassword(),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Row(children: const [
                Expanded(child: Divider(color: kColorsGrey)),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("or",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: kColorsGrey)),
                ),
                Expanded(child: Divider(color: kColorsGrey)),
              ]),
            ),
            const SizedBox(height: 10),
            InkWell(
                onTap: () {},
                child: const MainBtnWidget(
                    colorBtn: kColorsPurple,
                    textBtn: 'Sign Up with Google',
                    isTransparent: true,
                    haveIcon: true)),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }

  Widget createUsername() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: inputDecorationWidget(context, 'Username'),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter username";
            }
            return null;
          },
          onChanged: (value) {
            username = value;
          },
        ));
  }

  Widget createEmail() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: inputDecorationWidget(context, 'Email'),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter Email";
            }
            return null;
          },
          onChanged: (value) {
            email = value;
          },
        ));
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

  Widget createPassword() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: inputDecorationWidget(context, 'Password'),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter password";
            }
            return null;
          },
          onChanged: (value) {
            password = value;
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

  Widget createConfirmPassword() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: inputDecorationWidget(context, 'Confirm Password'),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter confirm password";
            } else if (password != null && value != password) {
              return "Those passwords didn't match. Try again.";
            }
            return null;
          },
          onChanged: (value) {
            confirmPassword = value;
          },
        ));
  }

  Future<void> registerHandle({required BuildContext context}) async {
    final AuthService authService =
        Provider.of<AuthService>(context, listen: false);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(strokeWidth: 4),
              ));

      try {
        await authService.createUser(
          email: email!,
          username: username!,
          password: password!,
          address: address,
          coin: 0,
          phone: phone,
          role: "role",
        );

        if (!mounted) return;
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } on fba.FirebaseAuthException catch (e) {
        log(e.message!);
        showSnackBar("Failed to authenticate to Firebase Auth - ${e.message}");
        Navigator.pop(context);
      }
    }
  }
}
