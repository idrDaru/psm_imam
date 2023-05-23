import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/models/parking_layout.dart';
import 'package:psm_imam/models/parking_location.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/models/parking_spot.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/services/networking.dart';

class HomeViewModel {
  // Future<void> getAllParkingSpace() async {
  //   WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
  //     Provider.of<UserProvider>(context, listen: false);
  //   });
  // }
  // Future<dynamic> getAllParkingLocations() async {
  //   Map<String, String> header = {
  //     'Content-Type': 'application/json',
  //   };

  //   NetworkHelper networkHelper =
  //       NetworkHelper(endpoint: '/api/parking-locations/', header: header);

  //   var response = await networkHelper.getData();
  //   var decodeResponse = jsonDecode(response.body);
  //   var data = decodeResponse['data'];

  //   List<ParkingLocation> parkingLocations = [];
  //   List<ParkingLayout> parkingLayout = [];
  //   List<ParkingSpot> parkingSpot = [];
  //   data.forEach(
  //     (value) {
  //       value['parkinglayout_set'].forEach((value) {
  //         value['parkingspot_set'].forEach(
  //           (value) {
  //             parkingSpot.add(
  //               ParkingSpot(
  //                 value['name'],
  //                 value['position'],
  //                 value['price'],
  //                 value['type'],
  //                 value['status'],
  //               ),
  //             );
  //           },
  //         );

  //         parkingLayout.add(
  //           ParkingLayout(
  //             value['car_spot_number'],
  //             value['motorcycle_spot_number'],
  //             value['position'],
  //             parkingSpot,
  //           ),
  //         );
  //       });
  //       parkingLocations.add(
  //         ParkingLocation(
  //           value['latitude'],
  //           value['longitude'],
  //           ParkingSpace(
  //             value['parking_space']['name'],
  //             value['parking_space']['address_line_one'],
  //             value['parking_space']['address_line_two'],
  //             value['parking_space']['city'],
  //             value['parking_space']['state_province'],
  //             value['parking_space']['country'],
  //             value['parking_space']['postal_code'],
  //             value['parking_space']['image_download_url'],
  //             value['parking_space']['parking_space_number'],
  //             value['parking_space']['is_active'],
  //             parkingLayout,
  //           ),
  //         ),
  //       );
  //     },
  //   );

  //   return parkingLocations;
  // }
}
