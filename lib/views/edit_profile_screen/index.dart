import 'package:flutter/material.dart';
import 'package:psm_imam/models/parking_provider.dart';
import 'package:psm_imam/models/parking_user.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/header.dart';
import 'package:psm_imam/views/components/shadow_text_field.dart';
import 'package:psm_imam/views/components/submit_button.dart';

class EditProfileScreen extends StatefulWidget {
  static String id = 'edit_profile_screen';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Map<String, String> data = {};
  String confirmPassword = '';

  void handleSubmit() {
    if (confirmPassword != data['password']) {
      print("SAME PASSWORD: " + data.toString());
    }
    print("Password not same");
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
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
                    const CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/194/194938.png',
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
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
