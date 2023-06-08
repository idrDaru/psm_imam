import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/models/booking.dart';

class EditBookingViewModel extends ChangeNotifier {
  bool isLoading = false;
  Booking? _booking;
  DateTime? oldDate;
  late int carCount = 0, motorcycleCount = 0;
  Set<String> selectedPosition = {};

  Booking? get booking => _booking;

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

  void setNewDate(DateTime newValue) {
    oldDate = newValue;
    notifyListeners();
  }

  Future<void> getBooking(String id) async {
    isLoading = true;
    notifyListeners();

    Booking booking = Booking();
    _booking = await booking.getBooking(id);
    setSelectedPosition(_booking!.parkingPosition!.toSet());
    setCarCount(_booking!.totalCar!);
    setMotorcycleCount(_booking!.totalMotorcycle!);
    oldDate = _booking!.timeFrom;

    isLoading = false;
    notifyListeners();
  }

  Future<Response> handleSubmitEditBooking(context, data, id) async {
    isLoading = true;
    notifyListeners();

    Booking booking = Booking();
    Response response = await booking.updateBooking(data, id);

    isLoading = false;
    notifyListeners();

    return response;
  }
}
