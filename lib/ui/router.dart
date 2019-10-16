

import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/app_constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Root:
        return MaterialPageRoute(builder: (_) => RootView());
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route deifned for ${settings.name}'),
            )
          )
        );
    }
  }
}