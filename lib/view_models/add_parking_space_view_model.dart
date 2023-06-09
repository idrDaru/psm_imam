import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:psm_imam/helpers/image_handler.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/constants/constants.dart';

class AddParkingSpaceViewModel extends ChangeNotifier {
  Map<String, dynamic> data = {
    'is_active': true,
    'parking_space_number': 27,
    'car_spot_number': 14,
    'motorcycle_spot_number': 13,
    'parking_spot': staticParkingSpot,
  };

  bool isLoading = false, isFormEmpty = false, isChecked = false;
  File? image;
  UploadTask? uploadTask;

  Future<Response> submitAddParkingSpace() async {
    isLoading = true;
    notifyListeners();

    await getParkingSpaceLocation();

    ParkingSpace parkingSpace = ParkingSpace();
    await uploadFile();
    Response response = await parkingSpace.addParkingSpace(data);

    isLoading = false;
    notifyListeners();

    return response;
  }

  void handleChange(String key, dynamic value) {
    isFormEmpty = false;
    data[key] = value;
    notifyListeners();
  }

  bool validateForm() {
    if (data['name'] == null || data['name'] == '') {
      return false;
    }

    if (data['address_line_one'] == null || data['address_line_one'] == '') {
      return false;
    }

    if (data['city'] == null || data['city'] == '') {
      return false;
    }

    if (data['state_province'] == null || data['state_province'] == '') {
      return false;
    }

    if (data['country'] == null || data['country'] == '') {
      return false;
    }

    if (data['postal_code'] == null || data['postal_code'] == '') {
      return false;
    }

    if (data['car_price'] == null || data['car_price'] == '') {
      data['car_price'] = 0.0;
    }

    if (data['motorcycle_price'] == null || data['motorcycle_price'] == '') {
      data['motorcycle_price'] = 0.0;
    }

    if (image == null) {
      return false;
    }

    if (!isChecked) {
      return false;
    }

    return true;
  }

  setIsFormEmpty(bool value) {
    isFormEmpty = value;
    notifyListeners();
  }

  setIsChecked(bool value) {
    isChecked = value;
    notifyListeners();
  }

  getParkingSpaceLocation() async {
    isLoading = true;
    notifyListeners();

    List<Location> locations = await locationFromAddress(
        '${data['address_line_one']}, ${data['address_line_two']}, ${data['postal_code']} ${data['city']}, ${data['state_province']}, ${data['country']}');

    data['latitude'] = locations[0].latitude;
    data['longitude'] = locations[0].longitude;

    isLoading = false;
    notifyListeners();
  }

  uploadFile() async {
    isLoading = true;
    notifyListeners();

    final path =
        '${profileFilePath}_${data['first_name']}${data['last_name'] == null ? "" : "_${data['last_name']}"}.jpg';
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(image!);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    data['image_download_url'] = urlDownload.toString();

    isLoading = false;
    notifyListeners();
  }

  Future handleImage() async {
    ImageHandler imagePickerHelper = ImageHandler();
    image = await imagePickerHelper.pickImageGallery();
    notifyListeners();
  }
}
