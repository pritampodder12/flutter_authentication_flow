import 'package:flutter/material.dart';

import '../pages/index.dart';
import '../constants/router_names.dart';

Route<dynamic> mainRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RouterNames.LOGIN:
      return MaterialPageRoute(builder: (context) => LoginPage());
      break;
    case RouterNames.SIGNUP:
      return MaterialPageRoute(builder: (context) => SignUp());
      break;
    case RouterNames.HOME:
      return MaterialPageRoute(builder: (context) => HomePage());
      break;
    case RouterNames.TEST:
      return MaterialPageRoute(builder: (context) => TestPage());
      break;
    default:
      return null;
  }
}
