import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psm_imam/models/booking.dart';
import 'package:psm_imam/models/parking_layout.dart';
import 'package:psm_imam/models/parking_location.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/models/parking_spot.dart';
import 'package:psm_imam/services/networking.dart';

class BookingProvider extends ChangeNotifier {
  dynamic _booking;
  bool isLoading = false;

  dynamic get booking => _booking;

  Future<void> getUserBooking() async {
    isLoading = true;
    notifyListeners();

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
    List<ParkingSpot> parkingSpot = [];
    List<String> parkingPosition = [];
    data.forEach(
      (value) {
        value['parking_space']['parkinglayout_set'].forEach((value) {
          value['parkingspot_set'].forEach((value) {
            parkingSpot.add(
              ParkingSpot(
                value['name'],
                value['position'],
                value['type'],
                value['status'],
              ),
            );
          });
        });

        value['parking_spot'].forEach((value) {
          parkingPosition.add(value);
        });

        bookings.add(
          Booking(
            value['is_purchased'],
            DateTime.parse(value['time_from']),
            DateTime.parse(value['time_to']),
            ParkingSpace(
              value['parking_space']['name'],
              value['parking_space']['address_line_one'],
              value['parking_space']['address_line_two'],
              value['parking_space']['city'],
              value['parking_space']['state_province'],
              value['parking_space']['country'],
              value['parking_space']['postal_code'],
              value['parking_space']['image_download_url'],
              value['parking_space']['parking_space_number'],
              value['parking_space']['is_active'],
              ParkingLayout(
                value['parking_space']['parkinglayout_set'][0]
                    ['car_spot_number'],
                value['parking_space']['parkinglayout_set'][0]
                    ['motorcycle_spot_number'],
                value['parking_space']['parkinglayout_set'][0]['position'],
                parkingSpot,
                value['parking_space']['parkinglayout_set'][0]['car_price'],
                value['parking_space']['parkinglayout_set'][0]
                    ['motorcycle_price'],
              ),
              ParkingLocation(
                value['parking_space']['parkinglocation_set'][0]['latitude'],
                value['parking_space']['parkinglocation_set'][0]['longitude'],
              ),
            ),
            value['total_car'],
            value['total_motorcycle'],
            value['total_price'],
            parkingPosition,
          ),
        );
      },
    );

    _booking = bookings;

    isLoading = false;
    notifyListeners();
  }
}
