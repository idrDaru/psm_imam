import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/models/parking_spaces.dart';

class ManageParkingSpaceViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<ParkingSpace>? _parkingSpaceList;

  List<ParkingSpace>? get parkingSpace => _parkingSpaceList;

  Future<void> getProviderParkingSpaces() async {
    isLoading = true;
    notifyListeners();

    ParkingSpace parkingSpace = ParkingSpace();
    _parkingSpaceList = await parkingSpace.getProviderParkingSpace();

    isLoading = false;
    notifyListeners();
  }

  Future<Response> handleIsActiveParkingSpace(
    String id,
    Map<String, dynamic> data,
  ) async {
    isLoading = true;
    notifyListeners();

    ParkingSpace parkingSpace = ParkingSpace();
    Response response = await parkingSpace.updateParkingSpace(id, data);

    isLoading = false;
    notifyListeners();

    return response;
  }
}
