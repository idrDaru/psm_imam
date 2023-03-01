import 'package:flutter/material.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/header.dart';
import 'package:psm_imam/views/components/shadow_text_field.dart';
import 'package:psm_imam/views/components/submit_button.dart';
import 'package:psm_imam/views/registrations_screen/user_registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              title: 'Login',
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 100.0,
                  bottom: 20.0,
                  left: 50.0,
                  right: 50.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ShadowTextField(title: 'Email Address'),
                    const ShadowTextField(title: 'Password'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: ((value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                        ),
                        const Text(
                          'Remember Me',
                          style: kTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SubmitButton(
                      title: "Login",
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: kTextStyle,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, UserRegistrationScreen.id);
                          },
                          child: Text(
                            "Create Account",
                            style: kTextStyle.copyWith(
                              color: const Color(0xFFE85A2A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
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
