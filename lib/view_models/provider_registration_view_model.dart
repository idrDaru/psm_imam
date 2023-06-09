import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/constants/constants.dart';
import 'package:psm_imam/helpers/image_handler.dart';
import 'package:psm_imam/services/networking.dart';

class ProviderRegistrationViewModel extends ChangeNotifier {
  bool isLoading = false, isFormEmpty = false, isAgree = false;
  File? image;
  UploadTask? uploadTask;
  Map<String, dynamic> data = {
    'type': '2',
  };

  Future<Response> submitForm() async {
    isLoading = true;
    notifyListeners();

    Map<String, String> header = {
      'Content-Type': 'application/json',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/register/',
      header: header,
      body: data,
    );
    await uploadFile();
    var response = await networkHelper.postData();

    isLoading = false;
    notifyListeners();

    return response;
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

  bool validateForm() {
    if (data['name'] == null || data['name'] == '') return false;

    if (data['address_line_one'] == null || data['address_line_one'] == '') {
      return false;
    }

    if (data['city'] == null || data['city'] == '') return false;

    if (data['state_province'] == null || data['state_province'] == '') {
      return false;
    }

    if (data['postal_code'] == null || data['postal_code'] == '') return false;

    if (data['email'] == null || data['email'] == '') return false;

    if (data['password'] == null || data['password'] == '') return false;

    if (data['confirm_password'] == null || data['confirm_password'] == '') {
      return false;
    }

    if (!isAgree) return false;

    return true;
  }

  void handleChange(String key, dynamic value) {
    data[key] = value;
    isFormEmpty = false;
    notifyListeners();
  }

  Future handleImage(BuildContext context) async {
    ImageHandler imagePickerHelper = ImageHandler();
    image = await imagePickerHelper.pickImageGallery();
    notifyListeners();
  }

  setIsFormEmpty(bool value) {
    isFormEmpty = value;
    notifyListeners();
  }

  setIsAgree(bool value) {
    isAgree = value;
    notifyListeners();
  }
}
