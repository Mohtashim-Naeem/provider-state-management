import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_app_ssp/models/bus_model.dart';
import 'package:form_app_ssp/models/user_model.dart';
import 'package:form_app_ssp/providers/auth_provider.dart';
import 'package:form_app_ssp/providers/form_provider.dart';
import 'package:form_app_ssp/utils/routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/route_model.dart';
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
  bool imageLoader = false;
  final NavigationService navigationService = locator<NavigationService>();
  final UtilService _utilService = locator<UtilService>();
  TextEditingController headwayAdherenceController = TextEditingController();
  TextEditingController busStopAdherenceController = TextEditingController();
  TextEditingController staffController = TextEditingController();
  TextEditingController anyotherController = TextEditingController();
  TextEditingController passengerController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();
  String itsValue = '';
  String itsFunctionalValue = '';
  List<int> items = List<int>.generate(100, (i) => i + 1);
  UserModel? user;
  List<BusModel>? bus = [];
  List<RouteModel>? route = [];
  bool initialLoader = false;
  List<DropdownMenuItem> busList = [];
  List<DropdownMenuItem> routeList = [];
  String? busName = '';
  String? routeName = '';
  String? headwayAdherenceValue = "";
  String? busStopAdherenceValue = "";
  List<DropdownMenuItem> itemList = [];
  String behaviourOfStaff = "";
  Position? position;

  String _locationMessage = "";
  final picker = ImagePicker();
  File _imageFile = File('');

  @override
  void initState() {
    user = Provider.of<AuthProvider>(context, listen: false).user;
    loadData();
    super.initState();
  }

  loadData() async {
    setState(() {
      initialLoader = true;
    });
    itemList = [];
    busList = [];
    routeList = [];
    await Provider.of<FormProvider>(context, listen: false).getAllBuses();
    await Provider.of<FormProvider>(context, listen: false).getAllRoutes();
    bus = Provider.of<FormProvider>(context, listen: false).bus;
    route = Provider.of<FormProvider>(context, listen: false).route;

    itemList.add(
      DropdownMenuItem(
        value: -1,
        child: Text(
          'Headway Adherence.',
          style: TextStyle(
            fontSize: 15,
            color: const Color.fromRGBO(89, 130, 130, 1),
          ),
        ),
      ),
    );
    itemList.addAll(items.map((int value) {
      return DropdownMenuItem<int>(
        value: value,
        child: Text(value.toString()),
      );
    }).toList());
    busList.add(
      DropdownMenuItem(
        value: -1,
        child: Text(
          'Bus No.',
          style: TextStyle(
            fontSize: 15,
            color: const Color.fromRGBO(89, 130, 130, 1),
          ),
        ),
      ),
    );
    for (int i = 0; i < bus!.length; i++) {
      busList.add(
        DropdownMenuItem(
          value: bus![i].busID,
          child: Text(
            bus![i].busNo.toString(),
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      );
    }
    routeList.add(
      DropdownMenuItem(
        value: -1,
        child: Text(
          'Route No.',
          style: TextStyle(
            fontSize: 15,
            color: const Color.fromRGBO(89, 130, 130, 1),
          ),
        ),
      ),
    );
    for (int i = 0; i < route!.length; i++) {
      routeList.add(
        DropdownMenuItem(
          value: route![i].routeID,
          child: Text(
            route![i].route.toString(),
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      );
    }
    setState(() {
      initialLoader = false;
    });
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await Provider.of<FormProvider>(context, listen: false)
          .uploadImage(pickedFile.path, pickedFile.name);
    } else {
      print('No image selected.');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      var permission = Geolocator.requestPermission();
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final List<Placemark> placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);

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

  // @override
  // void didUpdateWidget(covariant FormScreen oldWidget) {
  //   user = Provider.of<AuthProvider>(context, listen: false).user;
  //   loadData();
  //   super.didUpdateWidget(oldWidget);
  // }

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
      child: AbsorbPointer(
        absorbing: isLoadingProgress || imageLoader,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 214, 214, 214),

          // backgroundColor: Colors.transparent,
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
                        transitionDuration: const Duration(milliseconds: 200),
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
                      color: Colors.white,
                    ),
                  ),
                )
              ]),
          body: initialLoader
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Welcome ${user!.fullName}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: width * 0.50,
                        height: height * 0.25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
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
                        items: routeList,
                        value: value,
                        onChanged: (v) {
                          // var data = route!
                          //     .firstWhere((element) => element.routeID == v);
                          setState(() {
                            // routeName = data.route;
                            routeName = v.toString();
                          });
                        },
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
                        items: busList,
                        value: value,
                        onChanged: (v) {
                          // var data = bus!
                          //     .firstWhere((element) => element.busID == v);
                          setState(() {
                            // busName = data.busNo;
                            busName = v.toString();
                          });
                        },
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
                        height: height * 0.01,
                      ),
                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     'Bus No. ',
                      //     style: TextStyle(
                      //         color: Colors.black87,
                      //         fontSize: width * 0.04,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: height * 0.01,
                      // ),
                      DropdownButtonFormField(
                        // isDense: false,
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
                        items: itemList,
                        // value: value,
                        onChanged: (v) {
                          setState(() {
                            headwayAdherenceValue = value.toString();
                          });
                        },
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
                        onChanged: (v) {
                          setState(() {
                            busStopAdherenceValue = v == 1 ? "1" : "0";
                          });
                        },
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
                            itsValue = v == 1 ? '1' : '0';
                          });
                        },
                      ),
                      if (itsValue == '1')
                        SizedBox(
                          height: height * 0.01,
                        ),
                      if (itsValue == '1')
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
                                borderRadius:
                                    BorderRadius.circular(width * 0.02),
                                borderSide: BorderSide(
                                  // color: Color.fromARGB(15, 3, 71, 37),
                                  // color: Colors.green
                                  width: width * 0.005,
                                  color: const Color.fromARGB(255, 56, 154, 71),

                                  // color: const Color.fromARGB(255, 6, 69, 38),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.02),
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
                              itsFunctionalValue = v == 1 ? '1' : '0';
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                              borderRadius:
                                  BorderRadius.circular(width * 0.025),
                            ),
                            // backgroundColor: const Color.fromARGB(255, 6, 69, 38),
                            // backgroundColor: const Color.fromARGB(255, 56, 154, 71),
                            backgroundColor:
                                const Color.fromARGB(255, 189, 138, 49)
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
                                  size:
                                      MediaQuery.of(context).size.width * 0.12,
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
                      if (_locationMessage != "")
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
                                borderRadius:
                                    BorderRadius.circular(width * 0.02),
                                borderSide: BorderSide(
                                  // color: Color.fromARGB(15, 3, 71, 37),
                                  // color: Colors.green
                                  width: width * 0.005,
                                  color: const Color.fromARGB(255, 56, 154, 71),

                                  // color: const Color.fromARGB(255, 6, 69, 38),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.02),
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
                        onChanged: (v) {
                          behaviourOfStaff = v == 1
                              ? "Excellent"
                              : behaviourOfStaff =
                                  v == 2 ? 'Satisfactory' : 'Poor';
                        },
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
                          setState(() {
                            imageLoader = true;
                          });
                          await getImage();
                          setState(() {
                            imageLoader = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.025),
                          ),
                          // backgroundColor: const Color.fromARGB(255, 6, 69, 38),
                          // backgroundColor: const Color.fromARGB(255, 56, 154, 71),
                          backgroundColor:
                              const Color.fromARGB(255, 189, 138, 49)
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
                      if (imageLoader) CircularProgressIndicator(),
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
                          FocusScope.of(context).unfocus();
                          if (currentLocationController.text.isEmpty &&
                              _imageFile.path == '' &&
                              busName == '' &&
                              routeName == '' &&
                              position != null) {
                            _utilService.showToast('please fill all fields');
                            return;
                          }
                          setState(() {
                            isLoadingProgress = true;
                          });
                          var imageUrl =
                              Provider.of<FormProvider>(context, listen: false)
                                  .imageUrl;
                          var data = {
                            "UserID": user!.userID,
                            "FullName": user!.fullName,
                            "RouteID": routeName,
                            "BusID": busName,
                            "Manual": manualCheck! ? "1" : "0",
                            "HandHeldDevice": handheldDevices! ? "1" : "0",
                            "Card": card! ? "1" : "0",
                            "Headway": headwayAdherenceValue,
                            "BusStop": busStopAdherenceValue,
                            "ITSStatus": itsValue,
                            "BusCleaness": inside! ? "1" : "0",
                            "DriverUniform": driver! ? "1" : "0",
                            "ConductorUniform": conductor! ? "1" : "0",
                            "Behavior": behaviourOfStaff,
                            "Lat": position!.latitude,
                            "Long": position!.longitude,
                            "BusPicture": imageUrl,
                            // "https://smta.pk/Images/BusImages/3d9a9c7e-01e7-4bf1-934a-25c5ccea3a3b_1122.jpg",
                            "Remarks": anyotherController.text,
                            "PassengerCount": passengerController.text,
                            "Address": currentLocationController.text,
                            "ITSFunctional": itsFunctionalValue
                          };
                          await Provider.of<FormProvider>(context,
                                  listen: false)
                              .submitForm(data);
                          await Future.delayed(const Duration(seconds: 1));

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
                                      navigationService
                                          .navigateTo(formScreenRoute);
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

                          backgroundColor:
                              const Color.fromARGB(255, 56, 154, 71),

                          // backgroundColor:
                          //     const Color.fromARGB(255, 189, 138, 49)
                          //         .withOpacity(0.8),

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
    );
  }
}
