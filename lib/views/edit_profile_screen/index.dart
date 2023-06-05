import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/models/parking_provider.dart';
import 'package:psm_imam/models/parking_user.dart';
import 'package:psm_imam/services/networking.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/view_models/edit_profile_view_model.dart';
import 'package:psm_imam/view_models/profile_view_model.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getEditProfileScreenData();
    });
  }

  getEditProfileScreenData() async {
    await Provider.of<EditProfileViewModel>(context, listen: false).getUser();
  }

  handleSubmit() async {
    // if (confirmPassword != data['password']) {
    //   print("Password not same");
    // }

    // print("SAME PASSWORD: " + data.toString());

    Response response =
        await Provider.of<EditProfileViewModel>(context, listen: false)
            .handleSubmitEditProfile(data);
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
        body: Provider.of<EditProfileViewModel>(context).isLoading
            ? const LoadingScreen()
            : SingleChildScrollView(
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
                          child: Consumer<EditProfileViewModel>(
                            builder: (context, value, child) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: NetworkImage(
                                      value.user.user.imageDownloadURL,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  SubmitButton(
                                      title: 'Change Photo', onPressed: () {}),
                                  const SizedBox(height: 50.0),
                                  ShadowTextField(
                                    (newValue) {
                                      value.user is ParkingUser
                                          ? data['first_name'] = newValue
                                          : data['name'] = newValue;
                                    },
                                    title: value.user is ParkingUser
                                        ? value.user.firstName
                                        : value.user is ParkingProvider
                                            ? value.user.name
                                            : "",
                                  ),
                                  value.user is ParkingUser
                                      ? ShadowTextField(
                                          (newValue) =>
                                              data['last_name'] = newValue,
                                          title: value.user.lastName,
                                        )
                                      : Container(),
                                  value.user is ParkingProvider
                                      ? ShadowTextField(
                                          (newValue) =>
                                              data['address_line_one'] =
                                                  newValue,
                                          title: value.user.addressLineOne,
                                        )
                                      : Container(),
                                  value.user is ParkingProvider
                                      ? ShadowTextField(
                                          (newValue) =>
                                              data['address_line_two'] =
                                                  newValue,
                                          title: value.user.addressLineTwo,
                                        )
                                      : Container(),
                                  value.user is ParkingProvider
                                      ? ShadowTextField(
                                          (newValue) =>
                                              data['state_province'] = newValue,
                                          title: value.user.stateProvince,
                                        )
                                      : Container(),
                                  value.user is ParkingProvider
                                      ? ShadowTextField(
                                          (newValue) =>
                                              data['country'] = newValue,
                                          title: value.user.country,
                                        )
                                      : Container(),
                                  value.user is ParkingProvider
                                      ? ShadowTextField(
                                          (newValue) =>
                                              data['postal_code'] = newValue,
                                          title: value.user.postalCode,
                                        )
                                      : Container(),
                                  ShadowTextField(
                                    (newValue) => data['email'] = newValue,
                                    title: value.user.user.email,
                                  ),
                                  ShadowTextField(
                                      (newValue) => data['password'] = newValue,
                                      title: "************"),
                                  ShadowTextField(
                                      (newValue) => confirmPassword = newValue,
                                      title: "************"),
                                  const SizedBox(height: 20.0),
                                  SubmitButton(
                                    title: 'Save',
                                    onPressed: () {
                                      handleSubmit();
                                    },
                                  ),
                                ],
                              );
                            },
                          )),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
