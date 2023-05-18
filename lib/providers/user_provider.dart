import 'package:flutter/material.dart';
import 'package:psm_imam/view_models/user.dart';

class UserProvider extends ChangeNotifier {
  dynamic _user;
  bool isLoading = false;

  dynamic get user => _user;

  Future<void> getUserData() async {
    isLoading = true;
    notifyListeners();
    var userViewModel = UserViewModel();
    _user = await userViewModel.getUserData();
    isLoading = false;
    notifyListeners();
  }
}
