import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/home.dart';
import 'package:weather/pages/signupPage.dart';
import 'package:weather/services/api.dart';
import 'package:weather/services/firebaseServices.dart';
import 'package:weather/services/providerService.dart';
import 'package:weather/widgets/inputField.dart';
import 'package:weather/widgets/toast.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _emailController;
    String _passwordController;

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
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: _height * 0.04,
                      ),
                      InputField(
                        controller: _emailController,
                        hint: "email",
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: _height * 0.04,
                      ),
                      InputField(
                        controller: _passwordController,
                        hint: "password",
                        type: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      Consumer<ProviderService>(
                        builder: (context, value, child) {
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () async {
                                FirebaseAuth auth = FirebaseAuth.instance;

                                AuthenticationHelper()
                                    .signIn(
                                  email: value.newEmail,
                                  password: value.newPassword,
                                )
                                    .then(
                                  (result) {
                                    print(result.currentUser);
                                    if (result.currentUser != null) {
                                      showToast("Login Complted");
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return Home();
                                        },
                                      ));
                                    } else {
                                      showToast("Login Failed");
                                    }
                                  },
                                ).onError((
                                  FirebaseAuthException error,
                                  stackTrace,
                                ) {
                                  showToast(error.code);
                                });
                              },
                              child: const Text("Signin"));
                        },
                      ),
                      SizedBox(
                        height: _height * 0.02,
                        width: _width * 0.03,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account',
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Signup',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    color: Colors.green.shade300,
                                    fontSize: 20),
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
