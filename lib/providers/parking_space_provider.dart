import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psm_imam/models/parking_layout.dart';
import 'package:psm_imam/models/parking_location.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/models/parking_spot.dart';
import 'package:psm_imam/services/networking.dart';

class ParkingSpaceProvider extends ChangeNotifier {
  dynamic _parkingSpace;
  bool isLoading = false;

  dynamic get parkingSpace => _parkingSpace;

  Future<void> getAllParkingSpace() async {
    isLoading = true;
    notifyListeners();

    Map<String, String> header = {
      'Content-Type': 'application/json',
    };

    NetworkHelper networkHelper =
        NetworkHelper(endpoint: '/api/parking-spaces/', header: header);

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    var data = decodeResponse['data'];

    List<ParkingSpace> parkingSpace = [];
    List<ParkingSpot> parkingSpot = [];

    data.forEach((value) {
      value['parkinglayout_set'].forEach((value) {
        value['parkingspot_set'].forEach((value) {
          parkingSpot.add(
            ParkingSpot(
              value['id'],
              value['name'],
              value['position'],
              value['type'],
              value['status'],
            ),
          );
        });
      });

      parkingSpace.add(
        ParkingSpace(
          value['id'],
          value['name'],
          value['address_line_one'],
          value['address_line_two'],
          value['city'],
          value['state_province'],
          value['country'],
          value['postal_code'],
          value['image_download_url'],
          value['parking_space_number'],
          value['is_active'],
          ParkingLayout(
            value['parkinglayout_set'][0]['car_spot_number'],
            value['parkinglayout_set'][0]['motorcycle_spot_number'],
            value['parkinglayout_set'][0]['position'],
            parkingSpot,
            value['parkinglayout_set'][0]['car_price'],
            value['parkinglayout_set'][0]['motorcycle_price'],
          ),
          ParkingLocation(
            value['parkinglocation_set'][0]['latitude'],
            value['parkinglocation_set'][0]['longitude'],
          ),
        ),
      );
    });

    _parkingSpace = parkingSpace;

    isLoading = false;
    notifyListeners();
  }

  Future<void> getProviderParkingSpaceData() async {
    isLoading = true;
    notifyListeners();

    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/parking-space-provider/',
      header: header,
    );

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    var data = decodeResponse['data'];

    List<ParkingSpace> parkingSpaces = [];
    List<ParkingSpot> parkingSpot = [];

    data.forEach((value) {
      parkingSpaces.add(
        ParkingSpace(
          value['id'],
          value['name'],
          value['address_line_one'],
          value['address_line_two'],
          value['city'],
          value['state_province'],
          value['country'],
          value['postal_code'],
          value['image_download_url'],
          value['parking_space_number'],
          value['is_active'],
          ParkingLayout(
            value['parkinglayout_set'][0]['car_spot_number'],
            value['parkinglayout_set'][0]['motorcycle_spot_number'],
            value['parkinglayout_set'][0]['position'],
            parkingSpot,
            value['parkinglayout_set'][0]['car_price'],
            value['parkinglayout_set'][0]['motorcycle_price'],
          ),
          ParkingLocation(
            value['parkinglocation_set'][0]['latitude'],
            value['parkinglocation_set'][0]['longitude'],
          ),
        ),
      );
    });

    _parkingSpace = parkingSpaces;

    isLoading = false;
    notifyListeners();
  }
}
