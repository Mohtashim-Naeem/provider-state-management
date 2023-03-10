import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_app_ssp/utils/routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../services/navigation_service.dart';
import '../services/util_service.dart';
import '../utils/service_locator.dart';
import '../widgets/log_out_popup_widget.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool? manualCheck = false;
  bool? handheldDevices = false;
  bool? card = false;
  bool? outside = false;
  bool? inside = false;
  bool? driver = false;
  bool? conductor = false;
  bool isLoadingProgress = false;
  bool isLoadingLocation = false;
  final NavigationService navigationService = locator<NavigationService>();
  final UtilService _utilService = locator<UtilService>();
  TextEditingController headwayAdherenceController = TextEditingController();
  TextEditingController busStopAdherenceController = TextEditingController();
  TextEditingController staffController = TextEditingController();
  TextEditingController anyotherController = TextEditingController();
  TextEditingController passengerController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();
  String itsValue = '';
  List<int> items = List<int>.generate(100, (i) => i + 1);

  String _locationMessage = "";
  final picker = ImagePicker();
  File _imageFile = File('');

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      var permission = Geolocator.requestPermission();
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      final Placemark place = placemarks[0];
      final city = place.locality;
      final country = place.country;
      final address = place.administrativeArea;
      final street = place.street;

      setState(() {
        _locationMessage = "$street, $address, $city, $country.";
        currentLocationController.text = _locationMessage;
      });
    } catch (e) {
      setState(() {
        isLoadingLocation = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    currentLocationController.dispose();
    _locationMessage = "";
    _imageFile = File('');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var value = -1;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async => false,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.white,
    
              Color.fromARGB(255, 56, 154, 71),
              // Colors.green,
            ])),
        child: AbsorbPointer(
          absorbing: isLoadingProgress,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              // centerTitle: true,
              title: const Text('Sindh Mass Transit Authority'),
              backgroundColor: const Color.fromARGB(255, 56, 154, 71),
                            actions: [
                      InkWell(
                        onTap: () {
                          // if (data.route == "preview") {
                          showGeneralDialog(
                              barrierColor: Colors.black.withOpacity(0.5),
                              transitionBuilder: (context, a1, a2, widget) {
                                return Transform.scale(
                                  scale: a1.value,
                                  child: Opacity(
                                      opacity: a1.value,
                                      child: const LogoutAppPopup()),
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 200),
                              barrierDismissible: true,
                              barrierLabel: '',
                              context: context,
                              pageBuilder: (context, animation1, animation2) {
                                return const Text('PAGE BUILDER');
                              });
                          // } else {
                          //   Navigator.of(context).pop();
                          // }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, right: 15),
                          child: Icon(
                            Icons.logout,
                            size: 28,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ]),
            
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    'Welcome Admin',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    width: width * 0.50,
                    height: height * 0.25,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: Image.asset(
                      'assets/images/logo2.png',
                      // width: width * 0.5,
                      // height: height * 0.60,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Route No. ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    decoration: InputDecoration(
                      // hintText: 'Route No.',
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      // fillColor: Colors.white,
                      // filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            // color: Color.fromARGB(15, 3, 71, 37),
                            // color: Colors.green
                            width: width * 0.005,
                            color: const Color.fromARGB(255, 56, 154, 71),
    
                            // color: const Color.fromARGB(255, 6, 69, 38),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,
                            color: Colors.black,
                          )),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: -1,
                        child: Text(
                          'Route No.',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text(
                          'Route 1',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text(
                          'Route 2',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text(
                          'Route 3',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                    ],
                    value: value,
                    onChanged: (v) {},
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Bus No. ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      // fillColor: Colors.white,
                      // filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            // color: Color.fromARGB(15, 3, 71, 37),
                            // color: Colors.green
                            width: width * 0.005,
                            color: const Color.fromARGB(255, 56, 154, 71),
    
                            // color: const Color.fromARGB(255, 6, 69, 38),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,
                            color: Colors.black,
                          )),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: -1,
                        child: Text(
                          'Bus No.',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text(
                          'Abc 111',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.04,
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text(
                          'Abc 112',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text(
                          'Abc 113',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                    ],
                    value: value,
                    onChanged: (v) {},
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Ticketing System',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Text('Mannual'),
                  //         Checkbox(
                  //             value: is_cheked,
                  //             onChanged: (val) {
                  //               setState(() {
                  //                 is_cheked = val;
                  //               });
                  //             }),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Text('Hand held Devices'),
                  //         Checkbox(
                  //             value: is_cheked,
                  //             onChanged: (val) {
                  //               setState(() {
                  //                 is_cheked = val;
                  //               });
                  //             }),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Text('Mannual'),
                  //         Checkbox(
                  //             value: is_cheked,
                  //             onChanged: (val) {
                  //               setState(() {
                  //                 is_cheked = val;
                  //               });
                  //             }),
                  //       ],
                  //     )
                  //   ],
                  // ),
    
                  CheckboxListTile(
                      title: const Text('Manual'),
                      value: manualCheck,
                      onChanged: (val) {
                        setState(() {
                          manualCheck = val;
                        });
                      }),
                  CheckboxListTile(
                      title: const Text('Handheld Devices'),
                      value: handheldDevices,
                      onChanged: (val) {
                        setState(() {
                          handheldDevices = val;
                        });
                      }),
                  CheckboxListTile(
                      title: const Text('Card'),
                      value: card,
                      onChanged: (val) {
                        setState(() {
                          card = val;
                        });
                      }), // Container(
                  //   color: Colors.white,
                  //   child: DropdownButtonFormField(
                  //     decoration: InputDecoration(
                  //       hintText: '-Ticketing System',
                  //       suffixIcon: Icon(Icons.check_box),
                  //       suffixIconColor: const Color.fromARGB(255, 56, 154, 71),
                  //       contentPadding: EdgeInsets.symmetric(
                  //         vertical: height * 0.009,
                  //         horizontal: height * 0.015,
                  //       ),
                  //       // fillColor: Colors.white,
                  //       // filled: true,
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(width * 0.02),
                  //           borderSide: BorderSide(
                  //             // color: Color.fromARGB(15, 3, 71, 37),
                  //             // color: Colors.green
                  //             width: width * 0.005,
                  //             color: const Color.fromARGB(255, 56, 154, 71),
    
                  //             // color: const Color.fromARGB(255, 6, 69, 38),
                  //           )),
                  //       enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(width * 0.02),
                  //           borderSide: BorderSide(
                  //             width: width * 0.005,
                  //             color: Colors.black,
                  //           )),
                  //     ),
                  //     items: [
                  //       DropdownMenuItem(
                  //         // onTap: () {
                  //         //   Icon(Icons.check_box);
                  //         // },
                  //         child: Text(
                  //           '-Ticket System',
                  //           style: TextStyle(
                  //             fontSize: width * 0.04,
                  //             color: const Color.fromRGBO(89, 130, 130, 1),
                  //           ),
                  //         ),
                  //         value: -1,
                  //       ),
                  //       DropdownMenuItem(
                  //         child: Text(
                  //           'Manual',
                  //           style: TextStyle(
                  //             fontSize: width * 0.04,
                  //             color: const Color.fromRGBO(89, 130, 130, 1),
                  //           ),
                  //         ),
                  //         value: 1,
                  //       ),
                  //       DropdownMenuItem(
                  //         onTap: () {
                  //           Icon(
                  //             Icons.check_box,
                  //             color: Colors.green,
                  //           );
                  //         },
                  //         child: Text(
                  //           'Card',
                  //           style: TextStyle(
                  //             fontSize: width * 0.04,
                  //             color: const Color.fromRGBO(89, 130, 130, 1),
                  //           ),
                  //         ),
                  //         value: 2,
                  //       ),
                  //       DropdownMenuItem(
                  //         child: Text(
                  //           'Hand held Devices',
                  //           style: TextStyle(
                  //             fontSize: width * 0.04,
                  //             color: const Color.fromRGBO(89, 130, 130, 1),
                  //           ),
                  //         ),
                  //         value: 3,
                  //       ),
                  //     ],
                  //     value: _value,
                  //     onChanged: (v) {},
                  //   ),
                  // ),
                  SizedBox(
                    height: height * 0.04,
                  ),
    
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Headway Adherence ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Bus No. ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      // fillColor: Colors.white,
                      // filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            // color: Color.fromARGB(15, 3, 71, 37),
                            // color: Colors.green
                            width: width * 0.005,
                            color: const Color.fromARGB(255, 56, 154, 71),
    
                            // color: const Color.fromARGB(255, 6, 69, 38),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,
                            color: Colors.black,
                          )),
                    ),
                    items: items.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    value: value,
                    onChanged: (v) {},
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Bus Stop Adherence ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    decoration: InputDecoration(
                      // hintText: 'Route No.',
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      // fillColor: Colors.white,
                      // filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            // color: Color.fromARGB(15, 3, 71, 37),
                            // color: Colors.green
                            width: width * 0.005,
                            color: const Color.fromARGB(255, 56, 154, 71),
    
                            // color: const Color.fromARGB(255, 6, 69, 38),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,
                            color: Colors.black,
                          )),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: -1,
                        child: Text(
                          'Bus Stop Adherence',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text(
                          'No',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                    ],
                    value: value,
                    onChanged: (v) {},
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'ITS ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      // fillColor: Colors.white,
                      // filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            // color: Color.fromARGB(15, 3, 71, 37),
                            // color: Colors.green
                            width: width * 0.005,
                            color: const Color.fromARGB(255, 56, 154, 71),
    
                            // color: const Color.fromARGB(255, 6, 69, 38),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,
                            color: Colors.black,
                          )),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: -1,
                        child: Text(
                          'ITS',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text(
                          'Install',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text(
                          'Not Install',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                    ],
                    value: value,
                    onChanged: (v) {
                      setState(() {
                        itsValue = v == 1 ? 'Install' : 'Not Install';
                      });
                    },
                  ),
                  if (itsValue == 'Install')
                    SizedBox(
                      height: height * 0.01,
                    ),
                  if (itsValue == 'Install')
                    DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(width * 0.02),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: height * 0.009,
                          horizontal: height * 0.015,
                        ),
                        // fillColor: Colors.white,
                        // filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.02),
                            borderSide: BorderSide(
                              // color: Color.fromARGB(15, 3, 71, 37),
                              // color: Colors.green
                              width: width * 0.005,
                              color: const Color.fromARGB(255, 56, 154, 71),
    
                              // color: const Color.fromARGB(255, 6, 69, 38),
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.02),
                            borderSide: BorderSide(
                              width: width * 0.005,
                              color: Colors.black,
                            )),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: -1,
                          child: Text(
                            'ITS - Installed',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: const Color.fromRGBO(89, 130, 130, 1),
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text(
                            'Functional',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.black,
    
                              // color: const Color.fromRGBO(89, 130, 130, 1),
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text(
                            'Non-Functional',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: Colors.black,
    
                              // color: const Color.fromRGBO(89, 130, 130, 1),
                            ),
                          ),
                        ),
                      ],
                      value: value,
                      onChanged: (v) {
                        setState(() {
                          itsValue = v == 1 ? 'Installed' : 'Not Install';
                        });
                      },
                    ),
    
                  SizedBox(
                    height: height * 0.04,
                  ),
    
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Passenger Count ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
    
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextField(
                    controller: passengerController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onTap: () {},
                    style: TextStyle(fontSize: width * 0.04),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      // label: const Text(
                      //   'Pak Count.',
                      // ),
                      hintText: 'Passenger Count',
                      hintStyle: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            // color: Color.fromARGB(15, 3, 71, 37),
                            // color: Colors.green
                            width: width * 0.005,
                            color: const Color.fromARGB(255, 56, 154, 71),
    
                            // color: const Color.fromARGB(255, 6, 69, 38),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'GEO fence Location ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  if (_locationMessage == '')
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoadingLocation = true;
                        });
                        await _getCurrentLocation();
                        setState(() {
                          isLoadingLocation = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.025),
                        ),
                        // backgroundColor: const Color.fromARGB(255, 6, 69, 38),
                        // backgroundColor: const Color.fromARGB(255, 56, 154, 71),
                        backgroundColor: const Color.fromARGB(255, 189, 138, 49)
                            .withOpacity(0.8),
    
                        minimumSize: Size(width * 0.5, height * 0.07),
                        textStyle: TextStyle(
                          // color: Colors.,
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.04,
                        ),
                      ),
                      child: isLoadingLocation
                          ? SpinKitCircle(
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.12,
                            )
                          : Text(
                              'Get Location',
                              style: TextStyle(
                                fontSize: width * 0.05,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    readOnly: true,
                    controller: currentLocationController,
                    onTap: () {},
                    style: TextStyle(fontSize: width * 0.04),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      // label: const Text(
                      //   'GEO fence Picture',
                      // ),
                      hintText: 'Get Current Location',
                      hintStyle: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            // color: Color.fromARGB(15, 3, 71, 37),
                            // color: Colors.green
                            width: width * 0.005,
                            color: const Color.fromARGB(255, 56, 154, 71),
    
                            // color: const Color.fromARGB(255, 6, 69, 38),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Behavior of Staff. ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    decoration: InputDecoration(
                      // hintText: 'Route No.',
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      // fillColor: Colors.white,
                      // filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            // color: Color.fromARGB(15, 3, 71, 37),
                            // color: Colors.green
                            width: width * 0.005,
                            color: const Color.fromARGB(255, 56, 154, 71),
    
                            // color: const Color.fromARGB(255, 6, 69, 38),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,
                            color: Colors.black,
                          )),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: -1,
                        child: Text(
                          'Behavior of Staff',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text(
                          'Excellent',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text(
                          'Satisfactory',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text(
                          'Poor',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
    
                            // color: const Color.fromRGBO(89, 130, 130, 1),
                          ),
                        ),
                      ),
                    ],
                    value: value,
                    onChanged: (v) {},
                  ),
    
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Bus Cleanliness',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  // Container(
                  //   color: Colors.white,
                  //   child: DropdownButtonFormField(
                  //     decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.symmetric(
                  //         vertical: height * 0.009,
                  //         horizontal: height * 0.015,
                  //       ),
                  //       // fillColor: Colors.white,
                  //       // filled: true,
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(width * 0.02),
                  //           borderSide: BorderSide(
                  //             // color: Color.fromARGB(15, 3, 71, 37),
                  //             // color: Colors.green
                  //             color: const Color.fromARGB(255, 56, 154, 71),
    
                  //             width: width * 0.005,
                  //             // color: const Color.fromARGB(255, 6, 69, 38),
                  //           )),
                  //       enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(width * 0.02),
                  //           borderSide: BorderSide(
                  //             width: width * 0.005,
                  //             color: Colors.black,
                  //           )),
                  //     ),
                  //     items: [
                  //       DropdownMenuItem(
                  //         child: Text(
                  //           '-Bus Cleanliness',
                  //           style: TextStyle(
                  //             fontSize: width * 0.04,
                  //             color: const Color.fromRGBO(89, 130, 130, 1),
                  //           ),
                  //         ),
                  //         value: -1,
                  //       ),
                  //       DropdownMenuItem(
                  //         child: Text(
                  //           'Outside',
                  //           style: TextStyle(
                  //             fontSize: width * 0.04,
                  //             color: const Color.fromRGBO(89, 130, 130, 1),
                  //           ),
                  //         ),
                  //         value: 1,
                  //       ),
                  //       DropdownMenuItem(
                  //         child: Text(
                  //           'Inside',
                  //           style: TextStyle(
                  //             fontSize: width * 0.04,
                  //             color: const Color.fromRGBO(89, 130, 130, 1),
                  //           ),
                  //         ),
                  //         value: 2,
                  //       ),
                  //     ],
                  //     value: _value,
                  //     onChanged: (v) {},
                  //   ),
                  // ),
                  CheckboxListTile(
                      title: const Text('Outside'),
                      value: outside,
                      onChanged: (val) {
                        setState(() {
                          outside = val;
                        });
                      }),
                  CheckboxListTile(
                      title: const Text('Inside'),
                      value: inside,
                      onChanged: (val) {
                        setState(() {
                          inside = val;
                        });
                      }),
    
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Uniforms ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  // Container(
                  //   color: Colors.white,
                  //   child: DropdownButtonFormField(
                  //     // hint: Text('Uniforms'),
                  //     decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.symmetric(
                  //         vertical: height * 0.009,
                  //         horizontal: height * 0.015,
                  //       ),
                  //       // fillColor: Colors.white,
                  //       // filled: true,
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(width * 0.02),
                  //           borderSide: BorderSide(
                  //             // color: Color.fromARGB(15, 3, 71, 37),
                  //             // color: Colors.green
                  //             width: width * 0.005,
                  //             color: const Color.fromARGB(255, 56, 154, 71),
    
                  //             // color: const Color.fromARGB(255, 6, 69, 38),
                  //           )),
                  //       enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(width * 0.02),
                  //           borderSide: BorderSide(
                  //             width: width * 0.005,
                  //             color: Colors.black,
                  //           )),
                  //     ),
                  //     items: [
                  //       DropdownMenuItem(
                  //         child: Text(
                  //           '-Uniforms',
                  //           style: TextStyle(
                  //             fontSize: width * 0.04,
                  //             color: const Color.fromRGBO(89, 130, 130, 1),
                  //           ),
                  //         ),
                  //         value: -1,
                  //       ),
                  //       DropdownMenuItem(
                  //         child: Text(
                  //           'Driver',
                  //           style: TextStyle(
                  //             fontSize: width * 0.04,
                  //             color: const Color.fromRGBO(89, 130, 130, 1),
                  //           ),
                  //         ),
                  //         value: 1,
                  //       ),
                  //       DropdownMenuItem(
                  //         child: Text(
                  //           'Conductor',
                  //           style: TextStyle(
                  //             fontSize: width * 0.04,
                  //             color: const Color.fromRGBO(89, 130, 130, 1),
                  //           ),
                  //         ),
                  //         value: 2,
                  //       ),
                  //     ],
                  //     value: _value,
                  //     onChanged: (v) {},
                  //   ),
                  // ),
                  CheckboxListTile(
                      title: const Text('Driver'),
                      value: driver,
                      onChanged: (val) {
                        setState(() {
                          driver = val;
                        });
                      }),
                  CheckboxListTile(
                      // tileColor: Colors.white70,
                      title: const Text('Conductor'),
                      value: conductor,
                      onChanged: (val) {
                        setState(() {
                          conductor = val;
                        });
                      }),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Any other Observation / Remarks',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextField(
                    controller: anyotherController,
                    onTap: () {},
                    style: TextStyle(fontSize: width * 0.04),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      // label: const Text(
                      //   'Any other Obsvns/Rema',
                      // ),
                      hintText: 'Observation & Remarks',
                      hintStyle: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            // color: Color.fromARGB(15, 3, 71, 37),
                            color: const Color.fromARGB(255, 56, 154, 71),
    
                            // color: Colors.green
                            width: width * 0.005,
                            // color: const Color.fromARGB(255, 6, 69, 38),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  SizedBox(height: height * 0.08),
                  ElevatedButton(
                    onPressed: () async {
                      await getImage();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.025),
                      ),
                      // backgroundColor: const Color.fromARGB(255, 6, 69, 38),
                      // backgroundColor: const Color.fromARGB(255, 56, 154, 71),
                      backgroundColor: const Color.fromARGB(255, 189, 138, 49)
                          .withOpacity(0.8),
    
                      minimumSize: Size(width * 0.5, height * 0.07),
                      textStyle: TextStyle(
                        // color: Colors.,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.04,
                      ),
                    ),
                    child: Text(
                      'Take a Picture',
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (_imageFile.path != '')
                    Image.file(
                      _imageFile,
                      scale: 4,
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (currentLocationController.text.isEmpty &&
                          _imageFile.path == '') {
                        _utilService.showToast('please fill all fields');
                        return;
                      }
                      setState(() {
                        isLoadingProgress = true;
                      });
                      await Future.delayed(const Duration(seconds: 3));
                      // ignore: use_build_context_synchronously
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Thank You'),
                            content: const Text(
                                'Your data successfully sent to the server'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  // Perform some action
                                  navigationService.navigateTo(formScreenRoute);
                                },
                              ),
                            ],
                          );
                        },
                      );
                      setState(() {
                        isLoadingProgress = false;
                      });
    
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ProfileScreen()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.025),
                      ),
                      // backgroundColor: const Color.fromARGB(255, 6, 69, 38),
                      // backgroundColor: const Color.fromARGB(255, 56, 154, 71),
                      backgroundColor: const Color.fromARGB(255, 189, 138, 49)
                          .withOpacity(0.8),
    
                      minimumSize: Size(width * 0.90, height * 0.07),
                      textStyle: TextStyle(
                        // color: Colors.,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.04,
                      ),
                    ),
                    child: isLoadingProgress
                        ? SpinKitCircle(
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.12,
                          )
                        : Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: width * 0.05,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
