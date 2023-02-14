import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool? is_cheked = false;
  bool? check = false;
  bool? cheked = false;
  @override
  Widget build(BuildContext context) {
    var _value = -1;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.white,

            Color.fromARGB(255, 56, 154, 71),
            // Colors.green,
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Sindh Mass Transit Authourity'),
          // backgroundColor: const Color.fromARGB(255, 6, 69, 38),

          backgroundColor: const Color.fromARGB(255, 56, 154, 71),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(children: [
              // SizedBox(
              //   height: height * 0.03,
              // ),
              Container(
                width: width * 0.50,
                height: height * 0.30,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: Image.asset(
                  'images/logo2.png',
                  // width: width * 0.5,
                  // height: height * 0.60,
                ),
              ),
              SizedBox(
                height: height * 0.04,
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
                    child: Text(
                      'Route No.',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: -1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'x',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'y',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'z',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 3,
                  ),
                ],
                value: _value,
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
                    child: Text(
                      'Bus No.',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: -1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'x',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'y',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'z',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 3,
                  ),
                ],
                value: _value,
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
                  title: Text('Mannual'),
                  value: is_cheked,
                  onChanged: (val) {
                    setState(() {
                      is_cheked = val;
                    });
                  }),
              CheckboxListTile(
                  title: Text('Hand head Devices'),
                  value: check,
                  onChanged: (val) {
                    setState(() {
                      check = val;
                    });
                  }),
              CheckboxListTile(
                  title: Text('Card'),
                  value: cheked,
                  onChanged: (val) {
                    setState(() {
                      cheked = val;
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
              TextField(
                onTap: () {},
                style: TextStyle(fontSize: width * 0.04),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: height * 0.009,
                    horizontal: height * 0.015,
                  ),
                  hintText: 'Headway Adherence',
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
              TextField(
                onTap: () {},
                style: TextStyle(fontSize: width * 0.04),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: height * 0.009,
                    horizontal: height * 0.015,
                  ),
                  hintText: 'Bus Stop Adherence',
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
                        // color: const Color.fromARGB(255, 6, 69, 38),
                        color: const Color.fromARGB(255, 56, 154, 71),
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
                    child: Text(
                      'Functional',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: -1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Installed',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Non-Functional',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 2,
                  ),
                ],
                value: _value,
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
                  title: Text('Outside'),
                  value: is_cheked,
                  onChanged: (val) {
                    setState(() {
                      is_cheked = val;
                    });
                  }),
              CheckboxListTile(
                  title: Text('Inside'),
                  value: check,
                  onChanged: (val) {
                    setState(() {
                      check = val;
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
                  title: Text('Driver'),
                  value: is_cheked,
                  onChanged: (val) {
                    setState(() {
                      is_cheked = val;
                    });
                  }),
              CheckboxListTile(
                  title: Text('Conductor'),
                  value: check,
                  onChanged: (val) {
                    setState(() {
                      check = val;
                    });
                  }),

              SizedBox(
                height: height * 0.04,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Pak Count ',
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
                  //   'Pak Count.',
                  // ),
                  hintText: 'Pak Count',
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
                  'GEO fence Picture ',
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
                  hintText: 'GEO fence Picture',
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
              TextField(
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
                  //   'Behavior of Staff.',
                  // ),
                  hintText: 'Behavior of Staff.',
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
                  'Any other Obsvns/Rema ',
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
                  hintText: 'Any other Obsvns/Rema',
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
              Container(
                // color: Colors.transparent,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    gradient: LinearGradient(
                        // begin: Alignment.topLeft,
                        // end: Alignment.bottomRight,
                        colors: [
                          Colors.white,

                          Color.fromARGB(255, 56, 154, 71),
                          // Colors.green,
                        ])),
                child: ElevatedButton(
                  onPressed: () {
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
                    minimumSize: Size(width * 0.90, height * 0.08),
                    textStyle: TextStyle(
                      fontSize: height * 0.025,
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: width * 0.05),
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
    );
  }
}
