import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/models/user.dart';

class EditProfileViewModel extends ChangeNotifier {
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

  Future<Response> handleSubmitEditProfile(Map<String, String> data) async {
    isLoading = true;
    notifyListeners();

    User user = User();
    Response response = await user.updateUser(data);

    isLoading = false;
    notifyListeners();

    return response;
  }
}
