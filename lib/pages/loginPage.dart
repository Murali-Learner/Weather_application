import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather/pages/home.dart';
import 'package:weather/pages/signupPage.dart';
import 'package:weather/services/api.dart';
import 'package:weather/services/firebaseServices.dart';
import 'package:weather/widgets/inputField.dart';
import 'package:weather/widgets/toast.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("images/main.jpeg"),
            opacity: 0.5,
            fit: BoxFit.fill,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SafeArea(
            child: Center(
              child: Container(
                height: _height * 0.8,
                width: _height * 0.8,
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(_width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Weather Forecast",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.green),
                      ),
                      SizedBox(
                        height: _height * 0.04,
                      ),
                      InputField(emailController: _emailController),
                      SizedBox(
                        height: _height * 0.04,
                      ),
                      InputField(emailController: _passwordController),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {
                            AuthenticationHelper()
                                .signIn(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim())
                                .then(
                              (result) {
                                if (result == null) {
                                  print(result);

                                  showToast("  Successfully Login  ");
                                } else {
                                  showToast(result);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                }
                              },
                            );
                          },
                          child: const Text("Signin")),
                      SizedBox(
                        height: _height * 0.02,
                        width: _width * 0.03,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account',
                          children: <TextSpan>[
                            TextSpan(
                                text: '  Signup',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const Signup();
                                      },
                                    ));
                                  }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
