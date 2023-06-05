import 'package:flutter/material.dart';
import 'package:psm_imam/models/booking.dart';
import 'package:psm_imam/models/user.dart';

class ManageBookingViewModel extends ChangeNotifier {
  dynamic _user;
  List<Booking>? _bookingList;
  bool isLoading = false;

  dynamic get user => _user;
  dynamic get bookingList => _bookingList;

  Future<void> getUser() async {
    isLoading = true;
    notifyListeners();

    User user = User();
    _user = await user.getUser();

    isLoading = false;
    notifyListeners();
  }

  Future<void> getUserBooking() async {
    isLoading = true;
    notifyListeners();

    Booking booking = Booking();
    _bookingList = await booking.getUserBooking();

    isLoading = false;
    notifyListeners();
  }
}
