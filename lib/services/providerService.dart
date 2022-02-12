import 'package:flutter/foundation.dart';

class ProviderService extends ChangeNotifier {
  String newEmail = "";
  String newPassword = "";

  String newName = "";
  String newPhone = "";

  setEmail(String email) {
    newEmail = email;
    notifyListeners();
  }

  setPassword(String password) {
    newPassword = password;
    notifyListeners();
  }

  setPhone(String phone) {
    newPhone = phone;
    notifyListeners();
  }

  setName(String name) {
    newName = name;
    notifyListeners();
  }
}
