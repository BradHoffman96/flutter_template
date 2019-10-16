

import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/app_constants.dart';
import 'package:flutter_template/ui/views/home_view.dart';
import 'package:flutter_template/ui/views/login_view.dart';
import 'package:flutter_template/ui/views/root_view.dart';

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