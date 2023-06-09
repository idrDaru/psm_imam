import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/components/constants.dart';

class ImageHandler {
  UploadTask? _uploadTask;

  Future<File> pickImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    final imageFile = File(image!.path);
    return imageFile;
  }

  Future<File> pickImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return File('');

    final imageFile = File(image.path);
    return imageFile;
  }

  imagePickerDialog(BuildContext context) {
    Widget cancelButton = SubmitButton(
      title: 'Cancel',
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget cameraButton = SubmitButton(
      title: 'Camera',
      onPressed: pickImageCamera,
    );
    Widget galleryButton = SubmitButton(
      title: 'Gallery',
      onPressed: pickImageGallery,
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text("Select"),
      content: const Text("Which one you one to upload photo from?"),
      actions: [
        cancelButton,
        cameraButton,
        galleryButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  Future<String> uploadProfilePhoto(File file, String fileName) async {
    final path = '${profileFilePath}_$fileName.jpg';
    final ref = FirebaseStorage.instance.ref().child(path);
    _uploadTask = ref.putFile(file);

    final snapshot = await _uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }
}
