import 'package:flutter/material.dart';
import 'package:form_app_ssp/screens/form_screen.dart';
import 'package:form_app_ssp/screens/login_screen.dart';
import 'package:form_app_ssp/screens/splash_screen.dart';

const splashScreenRoute = '/splash-Screen';
const formScreenRoute = '/home-Screen';
const loginScreenRoute = '/Login-Screen';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen());

    case formScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const FormScreen());

    case loginScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen());

    default:
      return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen());
  }
}
