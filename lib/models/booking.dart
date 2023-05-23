import 'package:psm_imam/models/parking_spaces.dart';

class Booking {
  bool isPurchased;
  int totalCar, totalMotorcycle;
  double totalPrice;
  DateTime timeFrom, timeTo;
  ParkingSpace parkingSpace;
  List<String> parkingSpot;

  Booking(
    this.isPurchased,
    this.timeFrom,
    this.timeTo,
    this.parkingSpace,
    this.totalCar,
    this.totalMotorcycle,
    this.totalPrice,
    this.parkingSpot,
  );
}
