import 'dart:async';

import 'package:flutter/material.dart';

import '../services/storage_service.dart';
import '../utils/routes.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
// import '../widgets/exit_alert_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final navigationService = locator<NavigationService>();
  final storageService = locator<StorageService>();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      try {
        navigationService.navigateTo(loginScreenRoute);
      } catch (err) {
        navigationService.navigateTo(loginScreenRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future<bool> _onBackPressed() {
    //   return showDialog(
    //         context: context,
    //         builder: (context) => ExitAlertDialog(),
    //       ) ??
    //       false;
    // }

    // return WillPopScope(
    // onWillPop: _onBackPressed,
    return Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            child: Align(
                alignment: FractionalOffset.center,
                child: Container(
                    // child:
                    // Container(child: Image.asset('assets/images/logo.png')),

                    )),
          ),
        ]);
    // )
  }
}
