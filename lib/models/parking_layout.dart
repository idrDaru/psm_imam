import 'package:psm_imam/models/parking_spot.dart';

class ParkingLayout {
  int? carSpotNumber, motorcycleSpotNumber;
  double? carPrice, motorcyclePrice;
  String? position;
  List<ParkingSpot>? parkingSpot;

  ParkingLayout({
    this.carSpotNumber,
    this.motorcycleSpotNumber,
    this.position,
    this.parkingSpot,
    this.carPrice,
    this.motorcyclePrice,
  });
}
