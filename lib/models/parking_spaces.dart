import 'package:psm_imam/models/parking_layout.dart';
import 'package:psm_imam/models/parking_location.dart';

class ParkingSpace {
  String addressLineOne,
      addressLineTwo,
      city,
      stateProvince,
      country,
      postalCode,
      imageDownloadUrl,
      name,
      id;
  int parkingSpaceNumber;
  bool isActive;
  ParkingLayout parkingLayout;
  ParkingLocation parkingLocation;

  ParkingSpace(
    this.id,
    this.name,
    this.addressLineOne,
    this.addressLineTwo,
    this.city,
    this.stateProvince,
    this.country,
    this.postalCode,
    this.imageDownloadUrl,
    this.parkingSpaceNumber,
    this.isActive,
    this.parkingLayout,
    this.parkingLocation,
  );
}
