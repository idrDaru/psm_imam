import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:psm_imam/services/networking.dart';

class LoginViewModel {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  dynamic get storage => _storage;

  Future<Response> submitLogin(Map<String, String> data) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/login/',
      header: header,
      body: data,
    );

    var response = await networkHelper.postData();

    return response;
  }
}
