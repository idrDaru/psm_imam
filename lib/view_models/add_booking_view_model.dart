import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/services/networking.dart';
import 'package:psm_imam/views/manage_booking_screen/index.dart';

class AddBookingViewModel extends ChangeNotifier {
  ParkingSpace? _parkingSpaceDetails;
  bool isLoading = false;
  int carCount = 0, motorcycleCount = 0;
  Set<String> selectedPosition = {};

  ParkingSpace? get parkingSpaceDetails => _parkingSpaceDetails;

  setCarCount(int value) {
    carCount = value;
    notifyListeners();
  }

  setMotorcycleCount(int value) {
    motorcycleCount = value;
    notifyListeners();
  }

  setSelectedPosition(Set<String> value) {
    selectedPosition = value;
    notifyListeners();
  }

  Future<dynamic> submitAddBooking(context, data) async {
    isLoading = true;
    notifyListeners();

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
      isLoading = false;
      notifyListeners();

      Navigator.pushReplacementNamed(context, ManageBookingScreen.id);
    } else {
      print(decodeResponse['message']);
    }
  }

  Future<void> getParkingSpaceDetail(String id) async {
    isLoading = true;
    notifyListeners();

    ParkingSpace parkingSpace = ParkingSpace();
    _parkingSpaceDetails = await parkingSpace.getParkingSpaceDetail(id);

    isLoading = false;
    notifyListeners();
  }
}
