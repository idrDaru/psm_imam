import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/models/booking.dart';
import 'package:psm_imam/models/parking_spaces.dart';

class AddBookingViewModel extends ChangeNotifier {
  ParkingSpace? _parkingSpaceDetails;
  bool isLoading = false;
  int carCount = 0, motorcycleCount = 0;
  Set<String> selectedPosition = {};

  ParkingSpace? get parkingSpaceDetails => _parkingSpaceDetails;

  setCarCount(int value) {
    carCount = value;
    notifyListeners();
  }

  setMotorcycleCount(int value) {
    motorcycleCount = value;
    notifyListeners();
  }

  setSelectedPosition(Set<String> value) {
    selectedPosition = value;
    notifyListeners();
  }

  Future<Response> submitAddBooking(Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();

    Booking booking = Booking();
    Response response = await booking.addBooking(data);

    return response;
  }

  Future<void> getParkingSpaceDetail(String id) async {
    isLoading = true;
    notifyListeners();

    ParkingSpace parkingSpace = ParkingSpace();
    _parkingSpaceDetails = await parkingSpace.getParkingSpaceDetail(id);

    isLoading = false;
    notifyListeners();
  }
}
