import 'package:psm_imam/models/parking_spaces.dart';

class ParkingLocation {
  double latitude, longitude;
  ParkingSpace parkingSpace;

  ParkingLocation(
    this.latitude,
    this.longitude,
    this.parkingSpace,
  );
}
