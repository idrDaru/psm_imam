import 'package:psm_imam/models/user.dart';

class ParkingProvider {
  String? name,
      addressLineOne,
      addressLineTwo,
      city,
      stateProvince,
      country,
      postalCode;
  User? user;

  ParkingProvider({
    this.name,
    this.addressLineOne,
    this.addressLineTwo,
    this.city,
    this.country,
    this.postalCode,
    this.stateProvince,
    this.user,
  });
}
