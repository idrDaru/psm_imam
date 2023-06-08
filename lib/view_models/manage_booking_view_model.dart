import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/models/booking.dart';

class ManageBookingViewModel extends ChangeNotifier {
  List<Booking>? _bookingList;
  bool isLoading = false;

  dynamic get bookingList => _bookingList;

  Future<void> getUserBooking() async {
    isLoading = true;
    notifyListeners();

    Booking booking = Booking();
    _bookingList = await booking.getUserBooking();

    isLoading = false;
    notifyListeners();
  }

  Future<Response> deleteBooking(String id) async {
    isLoading = true;
    notifyListeners();

    Booking booking = Booking();
    Response response = await booking.deleteBooking(id);

    isLoading = false;
    notifyListeners();

    return response;
  }
}
