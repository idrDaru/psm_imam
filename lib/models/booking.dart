import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
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
                id: value['parking_space']['parkinglayout_set'][0]['id'],
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
                id: value['parking_space']['parkinglocation_set'][0]['id'],
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

  Future<Booking> getBooking(String id) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/booking/$id',
      header: header,
    );

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    var data = decodeResponse['data'];

    List<ParkingSpot> parkingSpot = [];
    data['parking_space']['parkinglayout_set'][0]['parkingspot_set'].forEach(
      (value) {
        parkingSpot.add(
          ParkingSpot(
            id: value['id'],
            name: value['name'],
            position: value['position'],
            type: value['type'],
            status: value['status'],
          ),
        );
      },
    );

    List<String> parkingPos = [];
    data['parking_spot'].forEach((value) {
      parkingPos.add(value.toString());
    });

    Booking booking = Booking(
      id: data['id'],
      isPurchased: data['is_purchased'],
      timeFrom: DateTime.parse(data['time_from']),
      timeTo: DateTime.parse(data['time_to']),
      parkingSpace: ParkingSpace(
        id: data['parking_space']['id'],
        name: data['parking_space']['name'],
        addressLineOne: data['parking_space']['address_line_one'],
        addressLineTwo: data['parking_space']['address_line_two'],
        city: data['parking_space']['city'],
        stateProvince: data['parking_space']['state_province'],
        country: data['parking_space']['country'],
        postalCode: data['parking_space']['postal_code'],
        imageDownloadUrl: data['parking_space']['image_download_url'],
        parkingSpaceNumber: data['parking_space']['parking_space_number'],
        isActive: data['parking_space']['is_active'],
        parkingLayout: ParkingLayout(
          id: data['parking_space']['parkinglayout_set'][0]['id'],
          carSpotNumber: data['parking_space']['parkinglayout_set'][0]
              ['car_spot_number'],
          motorcycleSpotNumber: data['parking_space']['parkinglayout_set'][0]
              ['motorcycle_spot_number'],
          position: data['parking_space']['parkinglayout_set'][0]['position'],
          parkingSpot: parkingSpot,
          carPrice: data['parking_space']['parkinglayout_set'][0]['car_price'],
          motorcyclePrice: data['parking_space']['parkinglayout_set'][0]
              ['motorcycle_price'],
        ),
        parkingLocation: ParkingLocation(
          id: data['parking_space']['parkinglocation_set'][0]['id'],
          latitude: data['parking_space']['parkinglocation_set'][0]['latitude'],
          longitude: data['parking_space']['parkinglocation_set'][0]
              ['longitude'],
        ),
      ),
      totalCar: data['total_car'],
      totalMotorcycle: data['total_motorcycle'],
      totalPrice: data['total_price'],
      parkingPosition: parkingPos,
    );

    return booking;
  }

  Future<Response> updateBooking(Map<String, dynamic> data, String id) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/booking/$id',
      header: header,
      body: data,
    );

    var response = await networkHelper.putData();
    return response;
  }

  Future<Response> deleteBooking(String id) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/booking/$id',
      header: header,
    );

    var response = await networkHelper.deleteData();
    return response;
  }

  Future<Response> addBooking(Map<String, dynamic> data) async {
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

    return response;
  }
}
