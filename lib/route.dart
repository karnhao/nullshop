import 'package:flutter/material.dart';
import 'package:nullshop/screens/add_product_screen.dart';
import 'package:nullshop/screens/google_account_signin.dart';
import 'package:nullshop/screens/home_screen.dart';
import 'package:nullshop/screens/login_screen.dart';
import 'package:nullshop/screens/product_info.dart';
import 'package:nullshop/screens/profile_screen.dart';
import 'package:nullshop/screens/register_screen.dart';
import 'package:nullshop/screens/top_up_screen.dart';
import 'package:nullshop/screens/transaction_screen.dart';
import 'package:nullshop/screens/withdraw_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => const HomeScreen(),
  "/add-product": (BuildContext context) => const AddProdectScreen(),
  "/product-info": (BuildContext context) => const ProductInfo(),
  "/profile": (BuildContext context) => const ProfileScreen(),
  "/top-up": (BuildContext context) => const TopUpScreen(),
  "/withdraw": (BuildContext context) => const WithdrawScreen(),
  "/transaction": (BuildContext context) => const TransactionScreen(),
  "/login": (BuildContext context) => const LoginScreen(),
  "/register": (BuildContext context) => const RegisterScreen(),
  "/google-account": (BuildContext context) => const Google_account_signin()
};
