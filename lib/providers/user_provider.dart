import 'package:flutter/material.dart';
import 'package:psm_imam/models/user.dart';

class UserProvider extends ChangeNotifier {
  dynamic _user;
  bool isLoading = false;

  dynamic get user => _user;

  Future<void> getUser() async {
    isLoading = true;
    notifyListeners();

    User user = User();
    _user = await user.getUser();

    isLoading = false;
    notifyListeners();
  }
}
