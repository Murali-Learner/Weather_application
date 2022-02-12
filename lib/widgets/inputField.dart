import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/services/providerService.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  String controller;
  String hint;
  TextInputType type;
  InputField({Key key, this.controller, this.hint, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var caller = Provider.of<ProviderService>(context, listen: false);
    return TextFormField(
      enableSuggestions: true,
      keyboardType: type,
      onChanged: (value) {
        if (hint == "email") {
          caller.setEmail(value);
        } else if (hint == "Name") {
          caller.setName(value);
        } else if (hint == "password") {
          caller.setPassword(value);
        } else if (hint == "Phone Number") {
          caller.setPhone(value);
        }

        // print("${caller.newPassword}  ${caller.newEmail}");
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.green),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
