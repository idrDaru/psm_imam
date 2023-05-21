class ParkingSpace {
  String addressLineOne,
      addressLineTwo,
      city,
      stateProvince,
      country,
      postalCode,
      imageDownloadUrl;
  int parkingSpaceNumber;
  bool isActive;

  ParkingSpace(
    this.addressLineOne,
    this.addressLineTwo,
    this.city,
    this.stateProvince,
    this.country,
    this.postalCode,
    this.imageDownloadUrl,
    this.parkingSpaceNumber,
    this.isActive,
  );
}
