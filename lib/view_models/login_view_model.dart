import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:psm_imam/services/networking.dart';

class LoginViewModel extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool isLoading = false;

  dynamic get storage => _storage;

  Future<Response> submitLogin(Map<String, String> data) async {
    isLoading = true;
    notifyListeners();

    Map<String, String> header = {
      'Content-Type': 'application/json',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/login/',
      header: header,
      body: data,
    );

    var response = await networkHelper.postData();

    isLoading = false;
    notifyListeners();

    return response;
  }
}
