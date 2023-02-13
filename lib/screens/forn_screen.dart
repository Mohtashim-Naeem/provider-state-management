import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    var _value = -1;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sindh Mass Transit Authourity'),
        backgroundColor: const Color.fromARGB(255, 6, 69, 38),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: height * 0.04,
            ),
            TextField(
              onTap: () {},
              style: TextStyle(fontSize: width * 0.04),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: height * 0.009,
                  horizontal: height * 0.015,
                ),
                label: const Text(
                  'Route No.',
                ),
                labelStyle: TextStyle(
                  fontSize: width * 0.04,
                  color: const Color.fromRGBO(89, 130, 130, 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    borderSide: BorderSide(
                      // color: Color.fromARGB(15, 3, 71, 37),
                      // color: Colors.green
                      width: width * 0.005,
                      color: const Color.fromARGB(255, 6, 69, 38),
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    borderSide: BorderSide(
                      width: width * 0.005,
                      // color: Colors.black,
                      color: const Color.fromARGB(255, 6, 69, 38),
                    )),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            TextField(
              onTap: () {},
              style: TextStyle(fontSize: width * 0.04),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: height * 0.009,
                  horizontal: height * 0.015,
                ),
                label: const Text(
                  'Bus No.',
                ),
                labelStyle: TextStyle(
                  fontSize: width * 0.04,
                  color: const Color.fromRGBO(89, 130, 130, 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    borderSide: BorderSide(
                      // color: Color.fromARGB(15, 3, 71, 37),
                      // color: Colors.green
                      width: width * 0.005,
                      color: const Color.fromARGB(255, 6, 69, 38),
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
            Container(
              color: Colors.white,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
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
                        color: const Color.fromARGB(255, 6, 69, 38),
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
                      '-Ticketing System',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: -1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Hand held Devices',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Card',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Hand held Devices',
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
            ),
            SizedBox(
              height: height * 0.04,
            ),
            TextField(
              onTap: () {},
              style: TextStyle(fontSize: width * 0.04),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: height * 0.009,
                  horizontal: height * 0.015,
                ),
                label: const Text(
                  'Headway Adherence',
                ),
                labelStyle: TextStyle(
                  fontSize: width * 0.04,
                  color: const Color.fromRGBO(89, 130, 130, 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    borderSide: BorderSide(
                      // color: Color.fromARGB(15, 3, 71, 37),
                      // color: Colors.green
                      width: width * 0.005,
                      color: const Color.fromARGB(255, 6, 69, 38),
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
            TextField(
              onTap: () {},
              style: TextStyle(fontSize: width * 0.04),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: height * 0.009,
                  horizontal: height * 0.015,
                ),
                label: const Text(
                  'Bus Stop Adherence',
                ),
                labelStyle: TextStyle(
                  fontSize: width * 0.04,
                  color: const Color.fromRGBO(89, 130, 130, 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    borderSide: BorderSide(
                      // color: Color.fromARGB(15, 3, 71, 37),
                      // color: Colors.green
                      width: width * 0.005,
                      color: const Color.fromARGB(255, 6, 69, 38),
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
            Container(
              color: Colors.white,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
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
                        color: const Color.fromARGB(255, 6, 69, 38),
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
                      '-ITS',
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
                      'Functional',
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
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
              color: Colors.white,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
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
                        color: const Color.fromARGB(255, 6, 69, 38),
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
                      '-Bus Cleanliness',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: -1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Outside',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Inside',
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
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
              color: Colors.white,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
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
                        color: const Color.fromARGB(255, 6, 69, 38),
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
                      '-Uniforms',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: -1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Driver',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                    ),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Conductor',
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
            ),
            SizedBox(
              height: height * 0.04,
            ),
            TextField(
              onTap: () {},
              style: TextStyle(fontSize: width * 0.04),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: height * 0.009,
                  horizontal: height * 0.015,
                ),
                label: const Text(
                  'Pak Count.',
                ),
                labelStyle: TextStyle(
                  fontSize: width * 0.04,
                  color: const Color.fromRGBO(89, 130, 130, 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    borderSide: BorderSide(
                      // color: Color.fromARGB(15, 3, 71, 37),
                      // color: Colors.green
                      width: width * 0.005,
                      color: const Color.fromARGB(255, 6, 69, 38),
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
            TextField(
              onTap: () {},
              style: TextStyle(fontSize: width * 0.04),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: height * 0.009,
                  horizontal: height * 0.015,
                ),
                label: const Text(
                  'GEO fence Picture',
                ),
                labelStyle: TextStyle(
                  fontSize: width * 0.04,
                  color: const Color.fromRGBO(89, 130, 130, 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    borderSide: BorderSide(
                      // color: Color.fromARGB(15, 3, 71, 37),
                      // color: Colors.green
                      width: width * 0.005,
                      color: const Color.fromARGB(255, 6, 69, 38),
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
            TextField(
              onTap: () {},
              style: TextStyle(fontSize: width * 0.04),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: height * 0.009,
                  horizontal: height * 0.015,
                ),
                label: const Text(
                  'Behavior of Staff.',
                ),
                labelStyle: TextStyle(
                  fontSize: width * 0.04,
                  color: const Color.fromRGBO(89, 130, 130, 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    borderSide: BorderSide(
                      // color: Color.fromARGB(15, 3, 71, 37),
                      // color: Colors.green
                      width: width * 0.005,
                      color: const Color.fromARGB(255, 6, 69, 38),
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
            TextField(
              onTap: () {},
              style: TextStyle(fontSize: width * 0.04),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: height * 0.009,
                  horizontal: height * 0.015,
                ),
                label: const Text(
                  'Any other Obsvns/Rema',
                ),
                labelStyle: TextStyle(
                  fontSize: width * 0.04,
                  color: const Color.fromRGBO(89, 130, 130, 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.02),
                    borderSide: BorderSide(
                      // color: Color.fromARGB(15, 3, 71, 37),
                      // color: Colors.green
                      width: width * 0.005,
                      color: const Color.fromARGB(255, 6, 69, 38),
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
                backgroundColor: const Color.fromARGB(255, 6, 69, 38),
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
            SizedBox(
              height: height * 0.025,
            ),
          ]),
        ),
      ),
    );
  }
}
