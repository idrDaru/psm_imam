import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/models/parking_provider.dart';
import 'package:psm_imam/models/parking_user.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/services/networking.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/views/profile_screen/index.dart';

class EditProfileScreen extends StatefulWidget {
  static String id = 'edit_profile_screen';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Map<String, String> data = {};
  String confirmPassword = '';

  handleSubmit() async {
    // if (confirmPassword != data['password']) {
    //   print("Password not same");
    // }

    // print("SAME PASSWORD: " + data.toString());
    const storage = FlutterSecureStorage();
    final key = await storage.read(key: 'access_token');

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $key',
    };

    NetworkHelper networkHelper = NetworkHelper(
      endpoint: '/api/user/',
      header: header,
      body: data,
    );

    var response = await networkHelper.putData();
    var decodeResponse = jsonDecode(response.body);
    if (decodeResponse['status'] == 200) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, ProfileScreen.id);
    } else {
      print(decodeResponse['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic user = ModalRoute.of(context)!.settings.arguments;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Text(
              'Back',
              style: kTextStyle,
            ),
          ),
          leadingWidth: 100.0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Header(title: 'Edit Profile'),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                    bottom: 50.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                          user.user.imageDownloadURL,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      SubmitButton(title: 'Change Photo', onPressed: () {}),
                      const SizedBox(height: 50.0),
                      ShadowTextField(
                        (value) {
                          user is ParkingUser
                              ? data['first_name'] = value
                              : data['name'] = value;
                        },
                        title: user is ParkingUser
                            ? user.firstName
                            : user is ParkingProvider
                                ? user.name
                                : "",
                      ),
                      user is ParkingUser
                          ? ShadowTextField(
                              (value) => data['last_name'] = value,
                              title: user.lastName,
                            )
                          : Container(),
                      user is ParkingProvider
                          ? ShadowTextField(
                              (value) => data['address_line_one'] = value,
                              title: user.addressLineOne,
                            )
                          : Container(),
                      user is ParkingProvider
                          ? ShadowTextField(
                              (value) => data['address_line_two'] = value,
                              title: user.addressLineTwo,
                            )
                          : Container(),
                      user is ParkingProvider
                          ? ShadowTextField(
                              (value) => data['state_province'] = value,
                              title: user.stateProvince,
                            )
                          : Container(),
                      user is ParkingProvider
                          ? ShadowTextField(
                              (value) => data['country'] = value,
                              title: user.country,
                            )
                          : Container(),
                      user is ParkingProvider
                          ? ShadowTextField(
                              (value) => data['postal_code'] = value,
                              title: user.postalCode,
                            )
                          : Container(),
                      ShadowTextField(
                        (value) => data['email'] = value,
                        title: user is ParkingUser
                            ? user.user.email
                            : user is ParkingProvider
                                ? user.user.email
                                : "",
                      ),
                      ShadowTextField((value) => data['password'] = value,
                          title: "************"),
                      ShadowTextField((value) => confirmPassword = value,
                          title: "************"),
                      const SizedBox(height: 20.0),
                      SubmitButton(
                        title: 'Save',
                        onPressed: () {
                          handleSubmit();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
