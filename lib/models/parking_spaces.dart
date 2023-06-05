import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psm_imam/models/parking_layout.dart';
import 'package:psm_imam/models/parking_location.dart';
import 'package:psm_imam/models/parking_spot.dart';
import 'package:psm_imam/services/networking.dart';

class ParkingSpace {
  String? addressLineOne,
      addressLineTwo,
      city,
      stateProvince,
      country,
      postalCode,
      imageDownloadUrl,
      name,
      id;
  int? parkingSpaceNumber;
  bool? isActive;
  ParkingLayout? parkingLayout;
  ParkingLocation? parkingLocation;

  ParkingSpace({
    this.id,
    this.name,
    this.addressLineOne,
    this.addressLineTwo,
    this.city,
    this.stateProvince,
    this.country,
    this.postalCode,
    this.imageDownloadUrl,
    this.parkingSpaceNumber,
    this.isActive,
    this.parkingLayout,
    this.parkingLocation,
  });

  Future<List<ParkingSpace>> getAllParkingSpace() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };

    NetworkHelper networkHelper =
        NetworkHelper(endpoint: '/api/parking-spaces/', header: header);

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    var data = decodeResponse['data'];

    List<ParkingSpace> parkingSpace = [];

    data.forEach((value) {
      List<ParkingSpot> parkingSpot = [];

      value['parkinglayout_set'].forEach((value) {
        value['parkingspot_set'].forEach((value) {
          parkingSpot.add(
            ParkingSpot(
              id: value['id'],
              name: value['name'],
              position: value['position'],
              type: value['type'],
              status: value['status'],
            ),
          );
        });
      });

      parkingSpace.add(
        ParkingSpace(
          id: value['id'],
          name: value['name'],
          addressLineOne: value['address_line_one'],
          addressLineTwo: value['address_line_two'],
          city: value['city'],
          stateProvince: value['state_province'],
          country: value['country'],
          postalCode: value['postal_code'],
          imageDownloadUrl: value['image_download_url'],
          parkingSpaceNumber: value['parking_space_number'],
          isActive: value['is_active'],
          parkingLayout: ParkingLayout(
            carSpotNumber: value['parkinglayout_set'][0]['car_spot_number'],
            motorcycleSpotNumber: value['parkinglayout_set'][0]
                ['motorcycle_spot_number'],
            position: value['parkinglayout_set'][0]['position'],
            parkingSpot: parkingSpot,
            carPrice: value['parkinglayout_set'][0]['car_price'],
            motorcyclePrice: value['parkinglayout_set'][0]['motorcycle_price'],
          ),
          parkingLocation: ParkingLocation(
            latitude: value['parkinglocation_set'][0]['latitude'],
            longitude: value['parkinglocation_set'][0]['longitude'],
          ),
        ),
      );
    });

    return parkingSpace;
  }

  Future<List<ParkingSpace>> getProviderParkingSpace() async {
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
          id: value['id'],
          name: value['name'],
          addressLineOne: value['address_line_one'],
          addressLineTwo: value['address_line_two'],
          city: value['city'],
          stateProvince: value['state_province'],
          country: value['country'],
          postalCode: value['postal_code'],
          imageDownloadUrl: value['image_download_url'],
          parkingSpaceNumber: value['parking_space_number'],
          isActive: value['is_active'],
          parkingLayout: ParkingLayout(
            carSpotNumber: value['parkinglayout_set'][0]['car_spot_number'],
            motorcycleSpotNumber: value['parkinglayout_set'][0]
                ['motorcycle_spot_number'],
            position: value['parkinglayout_set'][0]['position'],
            parkingSpot: parkingSpot,
            carPrice: value['parkinglayout_set'][0]['car_price'],
            motorcyclePrice: value['parkinglayout_set'][0]['motorcycle_price'],
          ),
          parkingLocation: ParkingLocation(
            latitude: value['parkinglocation_set'][0]['latitude'],
            longitude: value['parkinglocation_set'][0]['longitude'],
          ),
        ),
      );
    });

    return parkingSpaces;
  }
}
