import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrivateStorage {
  final storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    String? token = await storage.read(key: 'access_token');
    return token;
  }
}
