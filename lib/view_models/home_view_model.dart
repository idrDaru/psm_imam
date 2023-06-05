import 'package:flutter/material.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/models/user.dart';

class HomeViewModel extends ChangeNotifier {
  List<ParkingSpace> _parkingSpace = [];
  dynamic _user;
  bool isLoading = false;

  List<ParkingSpace> get parkingSpace => _parkingSpace;
  dynamic get user => _user;

  Future<void> getAllParkingSpace() async {
    isLoading = true;
    notifyListeners();

    ParkingSpace tmp = ParkingSpace();
    _parkingSpace = await tmp.getAllParkingSpace();

    isLoading = false;
    notifyListeners();
  }

  Future<void> getUser() async {
    isLoading = true;
    notifyListeners();

    User user = User();
    _user = await user.getUser();

    isLoading = false;
    notifyListeners();
  }
}
