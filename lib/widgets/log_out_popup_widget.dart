import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/navigation_service.dart';
import '../../utils/service_locator.dart';
import '../providers/auth_provider.dart';

class LogoutAppPopup extends StatefulWidget {
  const LogoutAppPopup({Key? key}) : super(key: key);

  @override
  State<LogoutAppPopup> createState() => _LogoutAppPopupState();
}

class _LogoutAppPopupState extends State<LogoutAppPopup> {
  var navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text(
      //   "Confirm",
      //   style: TextStyle(
      //
      //     fontWeight: FontWeight.w600,
      //     fontSize: MediaQuery.of(context).size.width * 0.05,
      //   ),
      // ),
      content: Text(
        "Are you sure you want to logout?",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: MediaQuery.of(context).size.width * 0.04,
        ),
      ),
      actions: <Widget>[
        TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () async {
              await Provider.of<AuthProvider>(context,listen:false).signOut();
              // Navigator.of(context).pop(false);
            },
            child: Text(
              "Yes",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.0001,
        ),
        TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Colors.grey,
            )),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              "No",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
            )),
        // SizedBox(
        //   width: MediaQuery.of(context).size.width * 0.07,
        // )
      ],
    );
  }
}
