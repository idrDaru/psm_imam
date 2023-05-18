import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psm_imam/models/parking_user.dart';
import 'package:psm_imam/models/parking_provider.dart';
import 'package:psm_imam/services/networking.dart';
import 'package:psm_imam/models/user.dart';

class UserViewModel {
  Future<dynamic> getUserData() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper =
        NetworkHelper(endpoint: '/api/user', header: header);

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    var data = decodeResponse['data'];

    User user = User(
      data['user']['type'],
      data['user']['email'].toString(),
      data['user']['profile_file_name'].toString(),
      data['user']['profile_file_path'].toString(),
      data['user']['is_verified'],
    );

    if (data['user']['type'] == 1) {
      return ParkingUser(
        data['first_name'].toString(),
        data['last_name'].toString(),
        user,
      );
    } else {
      return ParkingProvider(
        data['name'].toString(),
        data['address_line_one'].toString(),
        data['address_line_two'].toString(),
        data['city'].toString(),
        data['country'].toString(),
        data['postal_code'].toString(),
        data['state_province'],
        user,
      );
    }
  }

  void updateUserData() async {}
}
