import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psm_imam/models/parking_layout.dart';
import 'package:psm_imam/models/parking_location.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/models/parking_spot.dart';
import 'package:psm_imam/services/networking.dart';

class Booking {
  String? id;
  bool? isPurchased;
  int? totalCar, totalMotorcycle;
  double? totalPrice;
  DateTime? timeFrom, timeTo;
  ParkingSpace? parkingSpace;
  List<String>? parkingPosition;

  Booking({
    this.id,
    this.isPurchased,
    this.timeFrom,
    this.timeTo,
    this.parkingSpace,
    this.totalCar,
    this.totalMotorcycle,
    this.totalPrice,
    this.parkingPosition,
  });

  Future<List<Booking>> getUserBooking() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/user-booking/',
      header: header,
    );

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    var data = decodeResponse['data'];
    List<Booking> bookings = [];
    data.forEach(
      (value) {
        List<ParkingSpot> parkingSpot = [];
        List<String> parkingPosition = [];
        value['parking_space']['parkinglayout_set'].forEach((value) {
          value['parkingspot_set'].asMap().forEach((index, value) {
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

        value['parking_spot'].forEach((value) {
          parkingPosition.add(value);
        });

        bookings.add(
          Booking(
            id: value['id'],
            isPurchased: value['is_purchased'],
            timeFrom: DateTime.parse(value['time_from']),
            timeTo: DateTime.parse(value['time_to']),
            parkingSpace: ParkingSpace(
              id: value['parking_space']['id'],
              name: value['parking_space']['name'],
              addressLineOne: value['parking_space']['address_line_one'],
              addressLineTwo: value['parking_space']['address_line_two'],
              city: value['parking_space']['city'],
              stateProvince: value['parking_space']['state_province'],
              country: value['parking_space']['country'],
              postalCode: value['parking_space']['postal_code'],
              imageDownloadUrl: value['parking_space']['image_download_url'],
              parkingSpaceNumber: value['parking_space']
                  ['parking_space_number'],
              isActive: value['parking_space']['is_active'],
              parkingLayout: ParkingLayout(
                carSpotNumber: value['parking_space']['parkinglayout_set'][0]
                    ['car_spot_number'],
                motorcycleSpotNumber: value['parking_space']
                    ['parkinglayout_set'][0]['motorcycle_spot_number'],
                position: value['parking_space']['parkinglayout_set'][0]
                    ['position'],
                parkingSpot: parkingSpot,
                carPrice: value['parking_space']['parkinglayout_set'][0]
                    ['car_price'],
                motorcyclePrice: value['parking_space']['parkinglayout_set'][0]
                    ['motorcycle_price'],
              ),
              parkingLocation: ParkingLocation(
                latitude: value['parking_space']['parkinglocation_set'][0]
                    ['latitude'],
                longitude: value['parking_space']['parkinglocation_set'][0]
                    ['longitude'],
              ),
            ),
            totalCar: value['total_car'],
            totalMotorcycle: value['total_motorcycle'],
            totalPrice: value['total_price'],
            parkingPosition: parkingPosition,
          ),
        );
      },
    );

    return bookings;
  }
}
