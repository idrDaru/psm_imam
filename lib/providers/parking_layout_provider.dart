import 'package:flutter/material.dart';
import 'package:psm_imam/components/parking_layout.dart';

class ParkingLayoutProvider extends ChangeNotifier {
  List<Widget> motorcycle = [];
  List<Widget> car1 = [];
  List<Widget> car2 = [];
  Set<String> selectedPosition = {};

  handleData(dynamic data) {
    data.parkingSpot.forEach(
      (value) => {
        if (value.type == 1)
          {
            motorcycle.add(
              ParkingLayoutButton(
                type: value.type,
                isAvailable: value.status,
                id: value.id,
                callback: handleSelect,
              ),
            ),
          }
        else if (value.type == 2)
          {
            if (car1.length < 7)
              {
                car1.add(
                  ParkingLayoutButton(
                    type: value.type,
                    isAvailable: value.status,
                    id: value.id,
                    callback: handleSelect,
                  ),
                ),
              }
            else
              {
                car2.add(
                  ParkingLayoutButton(
                    type: value.type,
                    isAvailable: value.status,
                    id: value.id,
                    callback: handleSelect,
                  ),
                ),
              }
          }
      },
    );
    notifyListeners();
  }

  handleSelect(String id) {
    selectedPosition.contains(id)
        ? selectedPosition.remove(id)
        : selectedPosition.add(id);

    notifyListeners();
  }
}
