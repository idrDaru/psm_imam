import 'package:flutter/material.dart';
import 'package:psm_imam/models/booking.dart';
import 'package:psm_imam/models/parking_spaces.dart';

class ProfileViewModel extends ChangeNotifier {
  List<ParkingSpace>? _parkingSpaceList;
  List<Booking>? _bookingList;
  bool isLoading = false;

  List<ParkingSpace>? get parkingSpaceList => _parkingSpaceList;
  List<Booking>? get bookingList => _bookingList;

  Future<void> getParkingSpaceList() async {
    isLoading = true;
    notifyListeners();

    ParkingSpace parkingSpace = ParkingSpace();
    _parkingSpaceList = await parkingSpace.getProviderParkingSpace();

    isLoading = false;
    notifyListeners();
  }

  Future<void> getBookingList() async {
    isLoading = true;
    notifyListeners();

    Booking booking = Booking();
    _bookingList = await booking.getUserBooking();

    isLoading = false;
    notifyListeners();
  }

  DateTime getCurrentDate() {
    DateTime dateTime = DateTime.now();
    return dateTime;
  }
}
