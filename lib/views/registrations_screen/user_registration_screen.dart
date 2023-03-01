import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/header.dart';
import 'package:psm_imam/views/components/shadow_text_field.dart';
import 'package:psm_imam/views/components/submit_button.dart';
import 'package:psm_imam/views/login_screen/login_screen.dart';
import 'package:psm_imam/views/registrations_screen/provider_registration_screen.dart';

class UserRegistrationScreen extends StatefulWidget {
  static String id = 'user_registration_screen';
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
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
                    const ShadowTextField(title: 'First Name'),
                    const ShadowTextField(title: 'Last Name'),
                    const ShadowTextField(title: 'Email Address'),
                    const ShadowTextField(title: 'Password'),
                    const ShadowTextField(title: 'Confirm Passowrd'),
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
            ),
          ],
        ),
      ),
    );
  }
}
