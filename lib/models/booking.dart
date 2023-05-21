import 'package:psm_imam/models/parking_spaces.dart';

class Booking {
  bool isPurchased;
  DateTime date;
  String timeFrom, timeTo;
  ParkingSpace parkingSpace;

  Booking(
    this.isPurchased,
    this.date,
    this.timeFrom,
    this.timeTo,
    this.parkingSpace,
  );
}
