import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/constants/constants.dart';
import 'package:psm_imam/helpers/image_handler.dart';
import 'package:psm_imam/models/parking_spaces.dart';

class EditParkingSpaceViewModel extends ChangeNotifier {
  ParkingSpace? _parkingSpace;
  bool isLoading = false;
  Map<String, dynamic> data = {};
  File? image;
  UploadTask? uploadTask;

  ParkingSpace? get parkingSpace => _parkingSpace;

  Future<void> getParkingSpace(String id) async {
    isLoading = true;
    notifyListeners();

    ParkingSpace parkingSpace = ParkingSpace();
    _parkingSpace = await parkingSpace.getParkingSpaceDetail(id);

    isLoading = false;
    notifyListeners();
  }

  Future<Response> handleSubmitEditParkingSpace(String id) async {
    isLoading = true;
    notifyListeners();

    if (image != null) {
      await uploadFile();
    }
    ParkingSpace parkingSpace = ParkingSpace();
    Response response = await parkingSpace.updateParkingSpace(id, data);

    isLoading = false;
    notifyListeners();

    return response;
  }

  void handleChange(String key, dynamic value) {
    data[key] = value;
    notifyListeners();
  }

  Future handleImage() async {
    ImageHandler imagePickerHelper = ImageHandler();
    image = await imagePickerHelper.pickImageGallery();
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
}
