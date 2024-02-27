import 'dart:convert';

import 'package:account_management/screens/login_screen.dart';
import 'package:account_management/widgets/custom_edge.dart';
import 'package:account_management/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:account_management/config.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isNotValidate = false;

  void registerUser() async {
    if (_userNameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      if (_passwordTextController.text == _confirmPasswordController.text) {
        var regBody = {
          "username": _userNameTextController.text,
          "email": _emailTextController.text,
          "password": _passwordTextController.text
        };

        var response = await http.post(Uri.parse(registration),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));

        if (response.statusCode == 200) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          setState(() {
            _isNotValidate = true;
          });
        }

        print(response.statusCode);
      } else {
        setState(() {
          _isNotValidate = true;
        });
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // clipBehavior: Clip.none,
        // alignment: AlignmentDirectional.bottomCenter,
        children: [
          const CurvedEdgeWidget(),
          const Positioned(
            left: 20,
            right: 20,
            top: 100,
            child: Column(
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Sign into your account',
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
                top: 250,
                // bottom: -300,
                child: Container(
                  height: 500,
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
                              text: 'Enter Username',
                              prefixIcon: CupertinoIcons.person_alt,
                              isSuffix: false,
                              suffixIcon: Icons.account_circle_rounded,
                              isPasswordType: false,
                              controller: _userNameTextController),
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
                              prefixIcon: CupertinoIcons.lock_fill,
                              isSuffix: true,
                              suffixIcon: CupertinoIcons.eye_fill,
                              isPasswordType: true,
                              controller: _passwordTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWidget(
                              text: 'Enter Confirm password',
                              prefixIcon: CupertinoIcons.lock_fill,
                              isSuffix: true,
                              suffixIcon: CupertinoIcons.eye_fill,
                              isPasswordType: true,
                              controller: _confirmPasswordController),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                registerUser();
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
                                    'SIGN IN',
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
                                  "Already have an Account? ",
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
                                              const LoginScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Login",
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
