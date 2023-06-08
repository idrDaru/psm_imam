import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/helpers/image_picker.dart';
import 'package:psm_imam/services/networking.dart';
import 'package:psm_imam/constants/constants.dart';

class UserRegistrationViewModel extends ChangeNotifier {
  bool isLoading = false;
  File? image;
  UploadTask? uploadTask;
  Map<String, dynamic> data = {};

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
        '${profile_file_path}_${data['first_name']}${data['last_name'] == null ? "" : "_${data['last_name']}"}.jpg';
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(image!);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    data['image_download_url'] = urlDownload.toString();

    isLoading = false;
    notifyListeners();
  }

  bool validateForm() {
    if (data['password'] == data['confirm_password']) {
      return true;
    }
    return false;
  }

  void handleChange(String key, dynamic value) {
    data[key] = value;
    notifyListeners();
  }

  Future handleImage(
    BuildContext context,
  ) async {
    ImagePickerHelper imagePickerHelper = ImagePickerHelper();
    // imagePickerHelper.imagePickerDialog(context);
    image = await imagePickerHelper.pickImageGallery();
  }
}
