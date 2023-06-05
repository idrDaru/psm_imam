import 'package:flutter/material.dart';
import 'package:psm_imam/components/parking_layout.dart';
import 'package:psm_imam/models/parking_layout.dart';

class ParkingLayoutProvider extends ChangeNotifier {
  List<Widget> motorcycle = [];
  List<Widget> car1 = [];
  List<Widget> car2 = [];
  Set<String> selectedPosition = {};
  int carCount = 0;
  int motorcycleCount = 0;

  handleData(ParkingLayout data, bool isEditable) {
    // for (var value in data.parkingSpot) {
    //   if (value.type == 1) {
    //     motorcycle.add(ParkingLayoutButton(
    //       callback: handleSelect,
    //       data: value,
    //       isEditable: isEditable,
    //     ));
    //   } else if (value.type == 2) {
    //     if (car1.length < 7) {
    //       car1.add(ParkingLayoutButton(
    //         callback: handleSelect,
    //         data: value,
    //         isEditable: isEditable,
    //       ));
    //     } else {
    //       car2.add(ParkingLayoutButton(
    //         callback: handleSelect,
    //         data: value,
    //         isEditable: isEditable,
    //       ));
    //     }
    //   }
    // }
    // notifyListeners();
  }

  handleSelect(dynamic data) {
    if (selectedPosition.contains(data.id)) {
      selectedPosition.remove(data.id);
      if (data.type == 2) {
        carCount -= 1;
      } else if (data.type == 1) {
        motorcycleCount -= 1;
      }
    } else {
      if (data.type == 2) {
        carCount += 1;
      } else {
        motorcycleCount += 1;
      }
      selectedPosition.add(data.id);
    }

    notifyListeners();
  }
}
