// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/view_models/login_view_model.dart';
import 'package:psm_imam/views/home_screen/index.dart';
import 'package:psm_imam/views/registrations_screen/user_registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  Map<String, String> data = {
    'email': '',
    'password': '',
  };

  submitForm() async {
    LoginViewModel loginViewModel = LoginViewModel();

    Response response = await loginViewModel.submitLogin(data);

    var decodeResponse = jsonDecode(response.body);
    if (decodeResponse['status'] == 200) {
      await loginViewModel.storage.write(
        key: 'access_token',
        value: decodeResponse['data']['access_token'],
      );

      Navigator.pushNamed(context, HomeScreen.id);
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
                      ShadowTextField((value) {
                        return data['email'] = value;
                      }, title: 'Email Address'),
                      ShadowTextField((value) {
                        return data['password'] = value;
                      }, title: 'Password'),
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
                        onPressed: () {
                          submitForm();
                        },
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
      ),
    );
  }
}
