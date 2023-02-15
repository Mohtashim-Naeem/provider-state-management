import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(
            top: width * 0.02,
            left: width * 0.08,
            right: width * 0.08,
            bottom: width * 0.05,
          ),
          child: SingleChildScrollView(
            // scrollDirection: ,
            child: Form(
              child: Column(
                children: [
                  Container(
                    width: width * 0.50,
                    height: height * 0.30,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: Image.asset(
                      'images/logo2.png',
                    ),
                  ),

                  // SizedBox(
                  //   height: height * 0.02,
                  // ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Login ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'CNIC No.',
                  //       style: TextStyle(fontSize: width * 0.045),
                  //     )
                  //   ],
                  // ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Username ',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),

                  TextFormField(
                    style: TextStyle(fontSize: width * 0.04),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      hintText: 'Username',
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
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  // if (!_usernameValid) Text('Username is required'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Password ',
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
                    style: TextStyle(fontSize: width * 0.04),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      // prefixIcon: IconButton(icon: ic),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.009,
                        horizontal: height * 0.015,
                      ),
                      hintText: 'Password',
                      // label: const Text('Password'),
                      hintStyle: TextStyle(
                        fontSize: width * 0.04,
                        color: const Color.fromRGBO(89, 130, 130, 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            // color: Color(0xff1D2671),
                            // color: Color(0xffC33764),
                            // color: Colors.green,
                            width: width * 0.005,

                            color: const Color.fromARGB(255, 56, 154, 71),

                            // color: const Color.fromARGB(255, 6, 69, 38),
                          )),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.02),
                          borderSide: BorderSide(
                            width: width * 0.005,

                            // color: Color(0xffC33764),
                            // color: Color(0xff1D2671),
                            color: Colors.black,
                          )),
                    ),
                  ),
                  // if (!_passwordValid)
                  //   Text('Password must be at least 8 characters'),

                  SizedBox(height: height * 0.06),

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
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Container(
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(50),
                  //       gradient: LinearGradient(colors: [
                  //         // Color(0xff1D2671),
                  //         // Color(0xffC33764),

                  //         // Color.fromARGB(255, 41, 63, 132),
                  //         Color.fromARGB(255, 189, 138, 49),

                  //         // Color.fromARGB(255, 56, 154, 71),
                  //         // Color.fromARGB(255, 56, 154, 71),
                  //         Colors.white,

                  //         // Color.fromARGB(255, 68, 158, 74),
                  //         // Color.fromARGB(255, 189, 138, 49),
                  //       ])),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Navigator.push(
                  //       //     context,
                  //       //     MaterialPageRoute(
                  //       //         builder: (context) => login_screen()));
                  //     },
                  //     child: Text(
                  //       "Login",
                  //       style: TextStyle(
                  //         fontSize: width * 0.05,
                  //         //  shadows: [
                  //         // Shadow(
                  //         //     color: Colors.black.withOpacity(0.9),
                  //         //     offset: Offset(08, 12),
                  //         //     blurRadius: 05),
                  //         // ]
                  //       ),
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(50)

                  //           // borderRadius: BorderRadius.only(
                  //           //     topLeft: Radius.circular(25),
                  //           //     bottomRight: Radius.circular(25)),
                  //           ),
                  //       backgroundColor: Colors.transparent,
                  //       // backgroundColor: Color(0xFFffd004),
                  //       // backgroundColor: Col
                  //       // fixedSize: Size(width * 0.50, height * 0.075),
                  //       // maximumSize: Size(width * 0.50, height * 0.075)

                  //       minimumSize: Size(width * 0.90, height * 0.07),
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    height: height * 0.025,
                  ),
                  Text(
                    '© 2023-2024',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.03,
                        color: Theme.of(context).hintColor),
                  ),
                  Text(
                    'Sindh Govt.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.03,
                        color: Theme.of(context).hintColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
