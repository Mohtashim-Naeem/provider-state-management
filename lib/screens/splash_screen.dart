import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

    Timer(const Duration(seconds: 3), () async{
      try {
        var data = await storageService.haveBoolData('isLogin');
        if (data) {
          navigationService.navigateTo(formScreenRoute);
        } else {
          navigationService.navigateTo(loginScreenRoute);
        }
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              // Color.fromARGB(255, 41, 63, 132),
              // Color.fromARGB(255, 68, 158, 74)

              Colors.white,
              Color.fromARGB(255, 56, 154, 71),
              // Color(0xf159957),
              // Color(0xf155799),
              // Color(0xf45a247),
            ])),
        child: Stack(
            // fit: StackFit.expand,
            children: <Widget>[
              // Container(
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('assets/images/splash.jpg'),
              //         fit: BoxFit.cover),
              //   ),
              // ),
              Positioned(
                child: Align(
                    alignment: FractionalOffset.center,
                    child: Image.asset('assets/images/logo2.png')),
              ),

              Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        SpinKitDualRing(
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Version 1.0.0',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )),
              ),
            ]),
      ),
    );
    // )
  }
}
