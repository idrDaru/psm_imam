import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/header.dart';
import 'package:psm_imam/views/components/shadow_text_field.dart';
import 'package:psm_imam/views/components/submit_button.dart';
import 'package:psm_imam/views/login_screen/login_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const ShadowTextField(title: 'Company Name'),
                    const ShadowTextField(title: 'Address (Line 1)'),
                    const ShadowTextField(title: 'Address (Line 2) - Optional'),
                    const ShadowTextField(title: 'City'),
                    const ShadowTextField(title: 'Province/State'),
                    const ShadowTextField(title: 'Country'),
                    const ShadowTextField(title: 'Postal Code'),
                    const ShadowTextField(title: 'Email Address'),
                    const ShadowTextField(title: 'Password'),
                    const ShadowTextField(title: 'Confirm Password'),
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
                              text: 'By creating an account, you agree to our ',
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
                      onPressed: () {},
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
    );
  }
}
