import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_app_ssp/models/user_model.dart';
import 'package:form_app_ssp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

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

    Timer(const Duration(seconds: 3), () async {
      try {
        var data = await storageService.haveBoolData('isLogin');
        if (data) {
          var user = await storageService.getData('user');
          Provider.of<AuthProvider>(context, listen: false)
              .setData(UserModel.fromJson(user));
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 214, 214, 214),

        // backgroundColor: Colors.transparent,
        body: Stack(

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
                          color: Colors.green,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Version 1.0.0',
                          style: TextStyle(color: Colors.green),
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
