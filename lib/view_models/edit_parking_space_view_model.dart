import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/models/parking_spaces.dart';

class EditParkingSpaceViewModel extends ChangeNotifier {
  ParkingSpace? _parkingSpace;
  bool isLoading = false;
  Map<String, dynamic> data = {};

  ParkingSpace? get parkingSpace => _parkingSpace;

  Future<void> getParkingSpace(String id) async {
    isLoading = true;
    notifyListeners();

    ParkingSpace parkingSpace = ParkingSpace();
    _parkingSpace = await parkingSpace.getParkingSpaceDetail(id);

    isLoading = false;
    notifyListeners();
  }

  Future<Response> handleSubmitEditParkingSpace(String id) async {
    isLoading = true;
    notifyListeners();

    ParkingSpace parkingSpace = ParkingSpace();
    Response response = await parkingSpace.updateParkingSpace(id, data);

    isLoading = false;
    notifyListeners();

    return response;
  }

  void handleChange(String key, dynamic value) {
    data[key] = value;
    notifyListeners();
  }
}
