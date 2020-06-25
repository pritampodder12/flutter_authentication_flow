import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './constants/router_names.dart';
import './constants/color_names.dart';
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
        accentColor: Colors.white,
        primaryColor: ColorNames.primary,
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
        buttonTheme: ButtonThemeData(
            height: 40,
            buttonColor: ColorNames.primary,
            disabledColor: Colors.green.withOpacity(0.4),
            textTheme: ButtonTextTheme.accent),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
