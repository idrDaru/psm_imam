// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/view_models/provider_registration_view_model.dart';
import 'package:psm_imam/views/login_screen/index.dart';
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
  submitForm() async {
    bool validateForm = Provider.of<ProviderRegistrationViewModel>(
      context,
      listen: false,
    ).validateForm();

    if (validateForm) {
      Response response = await Provider.of<ProviderRegistrationViewModel>(
        context,
        listen: false,
      ).submitForm();

      var decodeResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        Navigator.pushNamed(context, LoginScreen.id);
      } else {
        print(decodeResponse['message']);
      }
    }
    Provider.of<ProviderRegistrationViewModel>(
      context,
      listen: false,
    ).setIsFormEmpty(true);
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
                  child: Consumer<ProviderRegistrationViewModel>(
                    builder: (context, value, child) {
                      return value.isLoading
                          ? const LoadingScreen()
                          : Column(
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
                                  onPressed: () async {
                                    await value.handleImage(context);
                                  },
                                ),
                                const SizedBox(height: 50.0),
                                value.isFormEmpty
                                    ? Center(
                                        child: Text(
                                          '** Please fill in required field',
                                          style: kTextStyle.copyWith(
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'name',
                                    newValue,
                                  );
                                }, title: '** Company Name'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'address_line_one',
                                    newValue,
                                  );
                                }, title: '** Address (Line 1)'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'address_line_two',
                                    newValue,
                                  );
                                }, title: 'Address (Line 2)'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'city',
                                    newValue,
                                  );
                                }, title: '** City'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'state_province',
                                    newValue,
                                  );
                                }, title: '** Province/State'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'country',
                                    newValue,
                                  );
                                }, title: '** Country'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'postal_code',
                                    newValue,
                                  );
                                }, title: '** Postal Code'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'email',
                                    newValue,
                                  );
                                }, title: '** Email Address'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'password',
                                    newValue,
                                  );
                                }, title: '** Password'),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'confirm_password',
                                    newValue,
                                  );
                                }, title: '** Confirm Password'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: value.isAgree,
                                      onChanged: (newValue) {
                                        value.setIsAgree(newValue!);
                                      },
                                    ),
                                    Flexible(
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              '** By creating an account, you agree to our ',
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
                              ],
                            );
                    },
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
