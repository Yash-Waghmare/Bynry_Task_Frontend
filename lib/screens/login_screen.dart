import 'dart:convert';

import 'package:account_management/config.dart';
import 'package:account_management/screens/dashboard_screen.dart';
import 'package:account_management/screens/signup_screen.dart';
import 'package:account_management/widgets/custom_edge.dart';
import 'package:account_management/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      var regBody = {
        'email': _emailTextController.text,
        'password': _passwordTextController.text
      };

      var response = await http.post(
        Uri.parse(login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardScreen(token: myToken)),
        );
      } else {
        print('Login Failed');
      }
    } else {
      print('Please enter email and password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CurvedEdgeWidget(),
          const Positioned(
            left: 20,
            right: 20,
            top: 100,
            child: Column(
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Positioned(
                left: 20,
                right: 20,
                top: 300,
                // bottom: -150,
                child: Container(
                  height: 380,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWidget(
                            text: 'Enter email',
                            isSuffix: false,
                            suffixIcon: Icons.account_circle_rounded,
                            isPasswordType: false,
                            controller: _emailTextController,
                            prefixIcon: CupertinoIcons.mail_solid,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWidget(
                            text: 'Enter password',
                            isSuffix: true,
                            prefixIcon: CupertinoIcons.lock_fill,
                            isPasswordType: true,
                            controller: _passwordTextController,
                            suffixIcon: CupertinoIcons.eye_fill,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 39, 23, 159),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                loginUser();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    return const Color.fromARGB(
                                        255, 39, 23, 159);
                                  }),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)))),
                              child: const Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Don't have an Account? ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 39, 23, 159),
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const CustomScreenClipper(),
      child: Container(
        height: 380,
        color: const Color.fromARGB(255, 39, 23, 159),
      ),
    );
  }
}
