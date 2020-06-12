import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './constants/router_names.dart';
import './routes/main_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
      initialRoute: prefs.getBool('loggedIn') != true
          ? RouterNames.LOGIN
          : RouterNames.HOME));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      onGenerateRoute: mainRoutes,
      theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.white,
          primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
    );
  }
}
