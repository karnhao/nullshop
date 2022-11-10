import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nullshop/services/auth_sesrvice.dart';
import 'package:nullshop/themes/colors.dart';
import 'package:nullshop/utils/show_snack_bar.dart';
import 'package:nullshop/widgets/input_decoration.dart';
import 'package:nullshop/widgets/main_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: kColorsWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, top: 20, bottom: 20),
                    child: Text('Null Shop',
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        createEmail(),
                        createPassword(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: InkWell(
                          onTap: () {
                            loginHandle(context: context);
                          },
                          child: const MainBtnWidget(
                              colorBtn: kColorsPurple,
                              textBtn: 'Login',
                              isTransparent: false,
                              haveIcon: false))),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Text('Forgot Password?',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: kColorsPurple)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 40),
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
                  InkWell(
                      onTap: () {},
                      child: const MainBtnWidget(
                          colorBtn: kColorsPurple,
                          textBtn: 'Login with Google',
                          isTransparent: true,
                          haveIcon: true)),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Don\'t have an account? ',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: kColorsGrey)),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  child: const Text('Sign Up',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: kColorsPurple))),
                            ])),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
              return "Please enter email";
            }
            return null;
          },
          onChanged: (value) {
            email = value;
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

  Future<void> loginHandle({required BuildContext context}) async {
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
        await authService.signInWithEmailAndPassword(
            email: email!, password: password!);
        if (!mounted) return;
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } on Exception catch (e) {
        log(e.toString());
        showSnackBar("An error has occurred - ${e.toString()}");
        Navigator.maybePop(context);
      }
    }
  }
}
