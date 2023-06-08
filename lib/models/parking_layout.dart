import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psm_imam/models/parking_spot.dart';
import 'package:psm_imam/services/networking.dart';

class ParkingLayout {
  int? carSpotNumber, motorcycleSpotNumber;
  double? carPrice, motorcyclePrice;
  String? position, id;
  List<ParkingSpot>? parkingSpot;

  ParkingLayout({
    this.id,
    this.carSpotNumber,
    this.motorcycleSpotNumber,
    this.position,
    this.parkingSpot,
    this.carPrice,
    this.motorcyclePrice,
  });

  Future<ParkingLayout> getParkingLayout(String id) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/parking-layout/$id',
      header: header,
    );

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    var data = decodeResponse['data'];

    List<ParkingSpot> parkingSpot = [];
    data['parkingspot_set'].forEach(
      (value) => {
        parkingSpot.add(
          ParkingSpot(
            id: value['id'],
            name: value['name'],
            position: value['position'],
            type: value['type'],
            status: value['status'],
          ),
        ),
      },
    );

    ParkingLayout parkingLayout = ParkingLayout(
      id: data['id'],
      carSpotNumber: data['car_spot_number'],
      motorcycleSpotNumber: data['motorcycle_spot_number'],
      carPrice: data['car_price'],
      motorcyclePrice: data['motorcycle_price'],
      position: data['position'],
      parkingSpot: parkingSpot,
    );

    return parkingLayout;
  }
}
