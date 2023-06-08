import 'package:flutter/material.dart';
import 'package:psm_imam/components/parking_layout.dart';
import 'package:psm_imam/models/parking_layout.dart';
import 'package:psm_imam/models/parking_spot.dart';

class ParkingLayoutViewModel extends ChangeNotifier {
  ParkingLayout? _parkingLayout;
  bool isEditable = false;
  bool isLoading = false;
  List<Widget> motorcycle = [];
  List<Widget> car1 = [];
  List<Widget> car2 = [];
  Set<String> selectedPosition = {};
  int carCount = 0, motorcycleCount = 0;

  ParkingLayout? get parkingLayout => _parkingLayout;

  getParkingSpot() async {
    for (var value in _parkingLayout!.parkingSpot!) {
      if (value.type == 1) {
        motorcycle.add(
          ParkingSpotButton(
            data: value,
            isEditable: isEditable,
          ),
        );
      } else if (value.type == 2) {
        if (car1.length < 7) {
          car1.add(
            ParkingSpotButton(
              data: value,
              isEditable: isEditable,
            ),
          );
        } else {
          car2.add(
            ParkingSpotButton(
              data: value,
              isEditable: isEditable,
            ),
          );
        }
      }
    }
    notifyListeners();
  }

  setCarCount(int value) {
    carCount = value;
    notifyListeners();
  }

  setMotorcycleCount(int value) {
    motorcycleCount = value;
    notifyListeners();
  }

  handleSelect(ParkingSpot data) async {
    if (selectedPosition.contains(data.id)) {
      selectedPosition.remove(data.id);
      if (data.type == 2) {
        setCarCount(carCount - 1);
      } else if (data.type == 1) {
        setMotorcycleCount(motorcycleCount - 1);
      }
    } else {
      if (data.type == 2) {
        setCarCount(carCount + 1);
      } else {
        setMotorcycleCount(motorcycleCount + 1);
      }
      selectedPosition.add(data.id!);
    }
    print(carCount);
    print(motorcycleCount);
    notifyListeners();
  }

  setIsEditable(bool value) {
    isEditable = value;
    notifyListeners();
  }

  setSelectedPotision(Set<String> value) async {
    selectedPosition = value;
    notifyListeners();
  }

  getParkingLayout(String id, Set<String> setSelectedPosition, int carCount,
      int motorcycleCount) async {
    isLoading = true;
    notifyListeners();

    ParkingLayout parkingLayout = ParkingLayout();
    _parkingLayout = await parkingLayout.getParkingLayout(id);
    setCarCount(carCount);
    setMotorcycleCount(motorcycleCount);
    await setSelectedPotision(setSelectedPosition);
    await getParkingSpot();

    isLoading = false;
    notifyListeners();
  }
}
