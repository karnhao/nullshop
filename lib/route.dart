import 'package:flutter/material.dart';
import 'package:nullshop/screens/add_product_screen.dart';
import 'package:nullshop/screens/home_screen.dart';
import 'package:nullshop/screens/product_info.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => const HomeScreen(),
  "/add-product": (BuildContext context) => const AddProdectScreen(),
  "/product-info": (BuildContext context) => const ProductInfo()
};
