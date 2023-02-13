import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // final _usernameController = TextEditingController();
    // final _passwordController = TextEditingController();

    bool _usernameValid = true;
    bool _passwordValid = true;

    void _validateUsername(String value) {
      setState(() {
        _usernameValid = value.trim().isNotEmpty;
      });
    }

    void _validatePassword(String value) {
      setState(() {
        _passwordValid = value.trim().length >= 8;
      });
    }

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: width * 0.02,
          left: width * 0.08,
          right: width * 0.08,
          bottom: width * 0.05,
        ),
        child: SingleChildScrollView(
          // scrollDirection: ,
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

              SizedBox(
                height: height * 0.01,
              ),
              Text(
                'Login ',
                style: TextStyle(
                    fontSize: width * 0.10, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.08,
              ),
              // Row(
              //   children: [
              //     Text(
              //       'CNIC No.',
              //       style: TextStyle(fontSize: width * 0.045),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 0.40,
              // ),
              TextField(
                controller: null,
                onChanged: _validateUsername,
                // onTap: () {},
                style: TextStyle(fontSize: width * 0.04),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: height * 0.009,
                    horizontal: height * 0.015,
                  ),
                  label: const Text(
                    'Username',
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
              if (!_usernameValid) Text('Username is required'),
              SizedBox(
                height: height * 0.04,
              ),
              TextField(
                controller: null,
                onChanged: _validatePassword,
                onTap: () {},

                style: TextStyle(fontSize: width * 0.04),
                // keyboardType: TextInputType.,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  // prefixIcon: IconButton(icon: ic),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: height * 0.009,
                    horizontal: height * 0.015,
                  ),
                  label: const Text('Password'),
                  labelStyle: TextStyle(
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
              if (!_passwordValid)
                Text('Password must be at least 8 characters'),

              SizedBox(height: height * 0.15),

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
                  backgroundColor: const Color.fromARGB(255, 56, 154, 71),

                  minimumSize: Size(width * 0.90, height * 0.08),
                  textStyle: TextStyle(
                    fontSize: height * 0.025,
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: width * 0.05),
                ),
              ),
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
    );
  }
}
