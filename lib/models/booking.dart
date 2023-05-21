import 'package:psm_imam/models/parking_spaces.dart';

class Booking {
  bool isPurchased;
  DateTime timeFrom, timeTo;
  ParkingSpace parkingSpace;

  Booking(
    this.isPurchased,
    this.timeFrom,
    this.timeTo,
    this.parkingSpace,
  );
}
