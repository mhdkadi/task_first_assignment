import 'package:flutter/material.dart';
import 'package:muhammad/helper/route/roter.dart';
import 'package:muhammad/view/screens/Sign_In/sign_in.dart';
import 'package:muhammad/view/screens/Sign_Up/sign_up.dart';
import 'package:muhammad/view/screens/profile/profile.dart';

class Routes {
  static Route<dynamic> routesGenerater(RouteSettings siettings) {
    switch (siettings.name) {
      case '\SignInScreen':
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case '\ProfileScreen':
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case '\RoutPage':
        return MaterialPageRoute(builder: (context) => RoutPage());
      case '\SignUpScreen':
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      default:
        return MaterialPageRoute(builder: (context) => SignInScreen());
    }
  }
}
