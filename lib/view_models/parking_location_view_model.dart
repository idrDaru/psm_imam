import 'package:flutter/material.dart';
import 'package:psm_imam/models/parking_location.dart';

class ParkingLocationViewModel extends ChangeNotifier {
  ParkingLocation? _parkingLocation;
  bool isLoading = false;

  ParkingLocation? get parkingLocation => _parkingLocation;

  Future<void> getParkingLocation(String id) async {
    isLoading = true;
    notifyListeners();

    ParkingLocation parkingLocation = ParkingLocation();
    _parkingLocation = await parkingLocation.getParkingLocation(id);

    isLoading = false;
    notifyListeners();
  }
}
