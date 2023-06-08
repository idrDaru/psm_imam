import 'package:flutter/material.dart';
import 'package:psm_imam/models/parking_spaces.dart';

class HomeViewModel extends ChangeNotifier {
  List<ParkingSpace> _parkingSpace = [];
  ParkingSpace? _parkingSpaceDetails;
  bool isLoading = false, isPopUp = false;

  List<ParkingSpace> get parkingSpace => _parkingSpace;
  ParkingSpace? get parkingSpaceDetail => _parkingSpaceDetails;

  Future<void> getAllParkingSpace() async {
    isLoading = true;
    notifyListeners();

    ParkingSpace tmp = ParkingSpace();
    _parkingSpace = await tmp.getAllParkingSpace();

    isLoading = false;
    notifyListeners();
  }

  setParkingSpaceDetails(ParkingSpace parkingSpace) {
    _parkingSpaceDetails = parkingSpace;
    notifyListeners();
  }

  setIsPopUp() {
    isPopUp = !isPopUp;
    notifyListeners();
  }
}
