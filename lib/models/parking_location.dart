import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psm_imam/services/networking.dart';

class ParkingLocation {
  String? id;
  double? latitude, longitude;

  ParkingLocation({
    this.id,
    this.latitude,
    this.longitude,
  });

  Future<ParkingLocation> getParkingLocation(String id) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/parking-location/$id',
      header: header,
    );

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    var data = decodeResponse['data'];

    ParkingLocation parkingLocation = ParkingLocation(
      id: data['id'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );

    return parkingLocation;
  }
}
