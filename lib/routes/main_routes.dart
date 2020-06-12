import 'package:flutter/material.dart';

import '../pages/index.dart';
import '../constants/router_names.dart';

Route<dynamic> mainRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RouterNames.LOGIN:
      return MaterialPageRoute(builder: (context) => LoginPage());
      break;
    case RouterNames.HOME:
      return MaterialPageRoute(
          builder: (context) => MyHomePage(
                title: 'Test authentication flow',
              ));
      break;
    default:
      return null;
  }
}
