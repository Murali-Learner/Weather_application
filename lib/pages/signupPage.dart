import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/loginPage.dart';
import 'package:weather/services/firebaseServices.dart';
import 'package:weather/services/providerService.dart';
import 'package:weather/widgets/inputField.dart';
import 'package:weather/widgets/toast.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    String _emailController;
    String _passwordController;
    // TextEditingController _phoneController = TextEditingController();
    // TextEditingController _nameController = TextEditingController();
    String _confirmPasswordController;

    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    // var items = ["Male", "Female"];
    // String dropdownvalue = items.first;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          width: _width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              opacity: 0.5,
              image: AssetImage("images/home.jpeg"),
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: SafeArea(
              child: Center(
                child: Container(
                  height: _height * 0.8,
                  width: _width * 0.8,
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
                          width: _width * 0.03,
                        ),
                        InputField(
                          controller: _emailController,
                          hint: "email",
                          type: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: _height * 0.04,
                          width: _width * 0.03,
                        ),
                        InputField(
                          controller: _passwordController,
                          type: TextInputType.visiblePassword,
                          hint: "password",
                        ),
                        SizedBox(
                          height: _height * 0.04,
                          width: _width * 0.03,
                        ),
                        Consumer<ProviderService>(builder:
                            (BuildContext context, value, Widget child) {
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () async {
                                print(value.newEmail);
                                print(value.newPassword);
                                FirebaseAuth auth = FirebaseAuth.instance;
                                await auth.signOut();
                                AuthenticationHelper()
                                    .signUp(
                                  email: value.newEmail,
                                  password: value.newPassword,
                                )
                                    .then(
                                  (result) {
                                    print(result.currentUser.toString());
                                    if (result.currentUser != null) {
                                      showToast("Signup Complted");
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const Login();
                                        },
                                      ));
                                    } else {
                                      showToast("Signup Failed");
                                    }
                                  },
                                ).onError((
                                  FirebaseAuthException error,
                                  stackTrace,
                                ) {
                                  showToast(error.code);
                                });
                              },
                              child: const Text("Signup"));
                        }),
                        RichText(
                          text: TextSpan(
                            text: 'Already have an account',
                            children: <TextSpan>[
                              TextSpan(
                                  text: '  Login',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return const Login();
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
      ),
    );
  }
}
