import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:psm_imam/models/parking_provider.dart';
import 'package:psm_imam/models/parking_user.dart';
import 'package:psm_imam/services/networking.dart';

class User {
  String? email, imageDownloadURL;
  int? type;
  bool? isVerified;

  User({
    this.type,
    this.email,
    this.imageDownloadURL,
    this.isVerified,
  });

  Future<dynamic> getUser() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper =
        NetworkHelper(endpoint: '/api/user/', header: header);

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    var data = decodeResponse['data'];

    User user = User(
      type: data['user']['type'],
      email: data['user']['email'].toString(),
      imageDownloadURL: data['user']['image_download_url'].toString(),
      isVerified: data['user']['is_verified'],
    );

    if (data['user']['type'] == 1) {
      return ParkingUser(
        firstName: data['first_name'].toString(),
        lastName: data['last_name'].toString(),
        user: user,
      );
    } else {
      return ParkingProvider(
        name: data['name'].toString(),
        addressLineOne: data['address_line_one'].toString(),
        addressLineTwo: data['address_line_two'].toString(),
        city: data['city'].toString(),
        country: data['country'].toString(),
        postalCode: data['postal_code'].toString(),
        stateProvince: data['state_province'],
        user: user,
      );
    }
  }

  Future<Response> updateUser(Map<String, String> data) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/user/',
      header: header,
      body: data,
    );

    var response = await networkHelper.putData();
    return response;
  }
}
