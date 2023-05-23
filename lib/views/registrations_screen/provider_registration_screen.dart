// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/views/login_screen/index.dart';
import 'package:psm_imam/services/networking.dart';
import 'dart:convert';

class ProviderRegistrationScreen extends StatefulWidget {
  static String id = 'provider_registration_screen';
  const ProviderRegistrationScreen({super.key});

  @override
  State<ProviderRegistrationScreen> createState() =>
      _ProviderRegistrationScreenState();
}

class _ProviderRegistrationScreenState
    extends State<ProviderRegistrationScreen> {
  bool isChecked = false;
  String name = '',
      addressLineOne = '',
      addressLineTwo = '',
      city = '',
      stateProvince = '',
      country = '',
      postalCode = '',
      email = '',
      password = '',
      confirmPassword = '';

  submitForm() async {
    Map<String, String> data = {
      'email': email,
      'password': password,
      'name': name,
      'address_line_one': addressLineOne,
      'address_line_two': addressLineTwo,
      'city': city,
      'state_province': stateProvince,
      'country': country,
      'postal_code': postalCode,
      'type': '2',
    };

    Map<String, String> header = {
      'Content-Type': 'application/json',
    };

    NetworkHelper networkHelper =
        NetworkHelper(endpoint: '/api/register/', header: header, body: data);
    var response = await networkHelper.postData();
    var decodeResponse = jsonDecode(response.body);
    if (response.statusCode == 201) {
      Navigator.pushNamed(context, LoginScreen.id);
    } else {
      print(decodeResponse['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Header(
                title: 'Create Account',
              ),
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
                      SubmitButton(title: 'Upload', onPressed: () {}),
                      const SizedBox(height: 50.0),
                      ShadowTextField((value) {
                        return name = value;
                      }, title: 'Company Name'),
                      ShadowTextField((value) {
                        return addressLineOne = value;
                      }, title: 'Address (Line 1)'),
                      ShadowTextField((value) {
                        return addressLineTwo = value;
                      }, title: 'Address (Line 2) - Optional'),
                      ShadowTextField((value) {
                        return city = value;
                      }, title: 'City'),
                      ShadowTextField((value) {
                        return stateProvince = value;
                      }, title: 'Province/State'),
                      ShadowTextField((value) {
                        return country = value;
                      }, title: 'Country'),
                      ShadowTextField((value) {
                        return postalCode = value;
                      }, title: 'Postal Code'),
                      ShadowTextField((value) {
                        return email = value;
                      }, title: 'Email Address'),
                      ShadowTextField((value) {
                        return password = value;
                      }, title: 'Password'),
                      ShadowTextField((value) {
                        return confirmPassword = value;
                      }, title: 'Confirm Password'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'By creating an account, you agree to our ',
                                style: kTextStyle.copyWith(
                                  fontSize: 13.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: kTextStyle.copyWith(
                                      color: const Color(0xFFE85A2A),
                                      fontSize: 13.0,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                  TextSpan(
                                    text: ' and agree to ',
                                    style: kTextStyle.copyWith(
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy & Policy',
                                    style: kTextStyle.copyWith(
                                      color: const Color(0xFFE85A2A),
                                      fontSize: 13.0,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SubmitButton(
                        title: 'Sign Up',
                        onPressed: () {
                          submitForm();
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Do you have an account?',
                            style: kTextStyle,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                            child: Text(
                              'Login',
                              style: kTextStyle.copyWith(
                                color: const Color(0xFFE85A2A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
