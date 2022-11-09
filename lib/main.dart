import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nullshop/route.dart';
import 'package:nullshop/themes/styles.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: "/login",
    );
  }
}
