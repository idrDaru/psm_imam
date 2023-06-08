// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/view_models/user_registration_view_model.dart';
import 'package:psm_imam/views/login_screen/index.dart';
import 'package:psm_imam/views/registrations_screen/provider_registration_screen.dart';
import 'dart:convert';
import 'package:psm_imam/services/networking.dart';

class UserRegistrationScreen extends StatefulWidget {
  static String id = 'user_registration_screen';
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  bool isChecked = false;

  submitForm() async {
    if (Provider.of<UserRegistrationViewModel>(context, listen: false)
        .validateForm()) {
      Response response = await Provider.of<UserRegistrationViewModel>(
        context,
        listen: false,
      ).submitForm();

      var decodeResponse = jsonDecode(response.body);

      if (decodeResponse['status'] == 201) {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      } else {
        print(decodeResponse['message']);
      }
    }
    print("Password Not Same");
  }

  pickImage(BuildContext context) async {
    await Provider.of<UserRegistrationViewModel>(
      context,
      listen: false,
    ).handleImage(context);
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
              Consumer<UserRegistrationViewModel>(
                builder: (context, value, child) {
                  return value.isLoading
                      ? const LoadingScreen()
                      : Center(
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
                                value.image != null
                                    ? CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: FileImage(
                                          value.image!,
                                        ),
                                      )
                                    : const CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: NetworkImage(
                                          'https://cdn-icons-png.flaticon.com/512/194/194938.png',
                                        ),
                                      ),
                                const SizedBox(height: 8.0),
                                SubmitButton(
                                  title: 'Upload',
                                  onPressed: () {
                                    pickImage(context);
                                  },
                                ),
                                const SizedBox(height: 50.0),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'first_name',
                                    newValue,
                                  );
                                }, title: 'First Name'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'last_name',
                                    newValue,
                                  );
                                }, title: 'Last Name'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'email',
                                    newValue,
                                  );
                                }, title: 'Email Address'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'password',
                                    newValue,
                                  );
                                }, title: 'Password'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'confirm_password',
                                    newValue,
                                  );
                                }, title: 'Confirm Passowrd'),
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
                                        Navigator.pushNamed(
                                            context, LoginScreen.id);
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
                                const SizedBox(height: 20.0),
                                const Text('You are a Parking Provider?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, ProviderRegistrationScreen.id);
                                  },
                                  child: Text(
                                    'Sign Up Here',
                                    style: kTextStyle.copyWith(
                                      color: const Color(0xFFE85A2A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
