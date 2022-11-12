import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nullshop/themes/colors.dart';
import 'package:nullshop/widgets/input_decoration.dart';
import 'package:nullshop/widgets/main_btn.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //default setting Scaffold
        // backgroundColor: kColorsCream,
        appBar: AppBar(
          // backgroundColor: kColorsPurple,
          leading: IconButton(
            icon:
                SvgPicture.asset('assets/icons/back.svg', color: kColorsPurple),
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
          ),
          // title: Text(
          //   "Reset Password",
          //   style: TextStyle(
          //       fontSize: 22.0,
          //       fontWeight: FontWeight.w600,
          //       color: kColorsPurple),
          // ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/resetpassword");
              },
              icon: const Icon(Icons.question_mark_outlined,
                  color: kColorsPurple),
            ),
          ],
        ),
        body: InkWell(
          onTap: (() {
            FocusScope.of(context).unfocus();
          }),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 150, bottom: 30),
                    child: Text(
                      "Reset Password",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Enter the email associated your account and we'll send an email with instructions to reset your password.",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: inputEmail(),
                  ),
                  InkWell(
                      onTap: () {},
                      child: const MainBtnWidget(
                          colorBtn: kColorsPurple,
                          textBtn: 'Enter',
                          isTransparent: false,
                          haveIcon: false)),
                ],
              ),
            ),
          ),
        ));
  }

  Widget inputEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: kColorsPurple),
        decoration: inputDecorationWidget(context, 'Email address'),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter email";
          }
          return null;
        },
        onChanged: (value) {
          email = value;
        },
      ),
    );
  }
}
