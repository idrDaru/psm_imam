import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psm_imam/services/networking.dart';

class AddBookingViewModel {
  Future<dynamic> submitAddBooking(context, data) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/create-booking/',
      header: header,
      body: data,
    );

    var response = await networkHelper.postData();
    var decodeResponse = jsonDecode(response.body);
    if (decodeResponse['status'] == 201) {
      Navigator.pop(context);
    } else {
      print(decodeResponse['message']);
    }
  }
}
