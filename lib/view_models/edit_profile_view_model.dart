import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/helpers/image_handler.dart';
import 'package:psm_imam/models/user.dart';

class EditProfileViewModel extends ChangeNotifier {
  dynamic _user;
  bool isLoading = false;
  File? image;
  UploadTask? uploadTask;

  Map<String, String> data = {};

  dynamic get user => _user;

  Future<void> getUser() async {
    isLoading = true;
    notifyListeners();

    User user = User();
    _user = await user.getUser();

    isLoading = false;
    notifyListeners();
  }

  Future<Response> handleSubmitEditProfile() async {
    isLoading = true;
    notifyListeners();

    if (image != null) {
      await uploadFile();
    }
    User user = User();
    Response response = await user.updateUser(data);

    isLoading = false;
    notifyListeners();

    return response;
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

  void handleChange(String key, dynamic value) {
    data[key] = value;
    notifyListeners();
  }
}
