import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nullshop/route.dart';
import 'package:nullshop/services/auth_service.dart';
import 'package:nullshop/services/database_service.dart';
import 'package:nullshop/services/database_service_interface.dart';
import 'package:nullshop/services/storage_service.dart';
import 'package:nullshop/themes/styles.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ErrorWidget.builder = ((details) {
    return Text('ERROR : ${details.exception}',
        style: const TextStyle(
            color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 20));
  });
  runApp(const App());
}

final messageKey = GlobalKey<ScaffoldMessengerState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseServiceInterface>(
            create: (context) => DatabaseService()),
        Provider<StorageService>(create: ((context) => StorageService())),
        ProxyProvider<DatabaseServiceInterface, AuthService>(
          update: (context, value, previous) => AuthService(dbs: value),
        )
      ],
      child: MaterialApp(
        scaffoldMessengerKey: messageKey,
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        routes: routes,
        initialRoute: "/login",
      ),
    );
  }
}
