import 'package:flutter/material.dart';
import 'package:nullshop/route.dart';
import 'package:nullshop/themes/styles.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      routes: routes,
      initialRoute: "/home",
    );
  }
}
