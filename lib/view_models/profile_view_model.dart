import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:psm_imam/models/booking.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/services/networking.dart';

class ProfileViewModel {
  // Future<dynamic> getProviderParkingSpace() async {
  // const storage = FlutterSecureStorage();
  // String? token = await storage.read(key: 'access_token');

  // Map<String, String> header = {
  //   'Content-Type': 'application/json',
  //   'Authorization': 'Bearer $token',
  // };

  // NetworkHelper networkHelper = NetworkHelper(
  //   endpoint: '/api/parking-space-provider/',
  //   header: header,
  // );

  // var response = await networkHelper.getData();
  // var decodeResponse = jsonDecode(response.body);
  // var data = decodeResponse['data'];

  // List<ParkingSpace> parkingSpaces = [];
  // data.forEach(
  //   (value) {
  //     parkingSpaces.add(
  //       ParkingSpace(
  //         value['name'],
  //         value['address_line_one'],
  //         value['address_line_two'],
  //         value['city'],
  //         value['state_province'],
  //         value['country'],
  //         value['postal_code'],
  //         value['image_download_url'],
  //         value['parking_space_number'],
  //         value['is_active'],
  //       ),
  //     );
  //   },
  // );

  // return parkingSpaces;
  // }

  // Future<dynamic> getUserBooking() async {
    // const storage = FlutterSecureStorage();
    // String? token = await storage.read(key: 'access_token');

    // Map<String, String> header = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $token',
    // };

    // NetworkHelper networkHelper = NetworkHelper(
    //   endpoint: '/api/user-booking/',
    //   header: header,
    // );

    // var response = await networkHelper.getData();
    // var decodeResponse = jsonDecode(response.body);
    // var data = decodeResponse['data'];
    // List<Booking> bookings = [];
    // data.forEach(
    //   (value) {
    //     bookings.add(
    //       Booking(
    //         value['is_purchased'],
    //         DateTime.parse(value['time_from']),
    //         DateTime.parse(value['time_to']),
    //         ParkingSpace(
    //           value['parking_space']['name'],
    //           value['parking_space']['address_line_one'],
    //           value['parking_space']['address_line_two'],
    //           value['parking_space']['city'],
    //           value['parking_space']['state_province'],
    //           value['parking_space']['country'],
    //           value['parking_space']['postal_code'],
    //           value['parking_space']['image_download_url'],
    //           value['parking_space']['parking_space_number'],
    //           value['parking_space']['is_active'],
    //         ),
    //       ),
    //     );
    //   },
    // );

    // return bookings;
  // }
}
