import 'package:flutter/material.dart';
import 'package:psm_imam/models/parking_spaces.dart';

class ParkingSpaceSummaryViewModel extends ChangeNotifier {
  ParkingSpace? _parkingSpace;
  bool isLoading = false;

  ParkingSpace? get parkingSpace => _parkingSpace;

  Future<void> getParkingSpace(String id) async {
    isLoading = true;
    notifyListeners();

    ParkingSpace parkingSpace = ParkingSpace();
    _parkingSpace = await parkingSpace.getParkingSpaceDetail(id);

    isLoading = false;
    notifyListeners();
  }
}
