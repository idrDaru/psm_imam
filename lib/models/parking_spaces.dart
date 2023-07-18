import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:psm_imam/models/booking.dart';
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
  List<Booking>? booking;

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
    this.booking,
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
            id: value['parkinglayout_set'][0]['id'],
            carSpotNumber: value['parkinglayout_set'][0]['car_spot_number'],
            motorcycleSpotNumber: value['parkinglayout_set'][0]
                ['motorcycle_spot_number'],
            position: value['parkinglayout_set'][0]['position'],
            parkingSpot: parkingSpot,
            carPrice: value['parkinglayout_set'][0]['car_price'],
            motorcyclePrice: value['parkinglayout_set'][0]['motorcycle_price'],
          ),
          parkingLocation: ParkingLocation(
            id: value['parkinglocation_set'][0]['id'],
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
            id: value['parkinglayout_set'][0]['id'],
            carSpotNumber: value['parkinglayout_set'][0]['car_spot_number'],
            motorcycleSpotNumber: value['parkinglayout_set'][0]
                ['motorcycle_spot_number'],
            position: value['parkinglayout_set'][0]['position'],
            parkingSpot: parkingSpot,
            carPrice: value['parkinglayout_set'][0]['car_price'],
            motorcyclePrice: value['parkinglayout_set'][0]['motorcycle_price'],
          ),
          parkingLocation: ParkingLocation(
            id: value['parkinglocation_set'][0]['id'],
            latitude: value['parkinglocation_set'][0]['latitude'],
            longitude: value['parkinglocation_set'][0]['longitude'],
          ),
        ),
      );
    });

    return parkingSpaces;
  }

  Future<ParkingSpace> getParkingSpaceDetail(String id) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/parking-space/$id',
      header: header,
    );

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    var data = decodeResponse['data'];

    List<ParkingSpot> parkingSpot = [];
    data['parkinglayout_set'].forEach((value) {
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

    List<Booking> bookings = [];
    data['booking_set'].forEach(
      (value) {
        List<String> bookingParkingPosition = [];
        value['parking_spot'].forEach(
          (value) {
            bookingParkingPosition.add(value);
          },
        );

        bookings.add(
          Booking(
            id: value['id'],
            isPurchased: value['is_purchased'],
            timeFrom: DateTime.parse(value['time_from']),
            timeTo: DateTime.parse(value['time_to']),
            totalCar: value['total_car'],
            totalMotorcycle: value['total_motorcycle'],
            totalPrice: value['total_price'],
            isActive: value['is_active'],
            isExpired: value['is_expired'],
            parkingPosition: bookingParkingPosition,
          ),
        );
      },
    );

    ParkingSpace parkingSpace = ParkingSpace(
      id: data['id'],
      name: data['name'],
      addressLineOne: data['address_line_one'],
      addressLineTwo: data['address_line_two'],
      city: data['city'],
      stateProvince: data['state_province'],
      country: data['country'],
      postalCode: data['postal_code'],
      imageDownloadUrl: data['image_download_url'],
      parkingSpaceNumber: data['parking_space_number'],
      isActive: data['is_active'],
      parkingLayout: ParkingLayout(
        id: data['parkinglayout_set'][0]['id'],
        carSpotNumber: data['parkinglayout_set'][0]['car_spot_number'],
        motorcycleSpotNumber: data['parkinglayout_set'][0]
            ['motorcycle_spot_number'],
        position: data['parkinglayout_set'][0]['position'],
        parkingSpot: parkingSpot,
        carPrice: data['parkinglayout_set'][0]['car_price'],
        motorcyclePrice: data['parkinglayout_set'][0]['motorcycle_price'],
      ),
      parkingLocation: ParkingLocation(
        id: data['parkinglocation_set'][0]['id'],
        latitude: data['parkinglocation_set'][0]['latitude'],
        longitude: data['parkinglocation_set'][0]['longitude'],
      ),
      booking: bookings,
    );

    return parkingSpace;
  }

  Future<Response> updateParkingSpace(
    String id,
    Map<String, dynamic> data,
  ) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/parking-space/$id',
      header: header,
      body: data,
    );

    var response = await networkHelper.putData();
    return response;
  }

  Future<Response> addParkingSpace(Map<String, dynamic> data) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/parking-space-provider/',
      header: header,
      body: data,
    );

    var response = await networkHelper.postData();

    return response;
  }
}
