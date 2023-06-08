// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/view_models/add_parking_space_view_model.dart';
import 'package:psm_imam/views/manage_parking_space_screen/index.dart';

class AddParkingSpaceScreen extends StatefulWidget {
  static String id = 'add_parking_space_screen';
  const AddParkingSpaceScreen({super.key});

  @override
  State<AddParkingSpaceScreen> createState() => _AddParkingSpaceScreenState();
}

class _AddParkingSpaceScreenState extends State<AddParkingSpaceScreen> {
  handleSubmit() async {
    bool validateForm = Provider.of<AddParkingSpaceViewModel>(
      context,
      listen: false,
    ).validateForm();

    if (validateForm) {
      Response response = await Provider.of<AddParkingSpaceViewModel>(
        context,
        listen: false,
      ).submitAddParkingSpace();

      var decodeResponse = jsonDecode(response.body);
      if (decodeResponse['status'] == 201) {
        Navigator.pushReplacementNamed(context, ManageParkingSpaceScreen.id);
      } else {
        print(decodeResponse['message']);
      }
    }

    Provider.of<AddParkingSpaceViewModel>(
      context,
      listen: false,
    ).setIsFormEmpty(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Provider.of<AddParkingSpaceViewModel>(context).isLoading
            ? const LoadingScreen()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Header(title: 'Add Parking Space'),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 50.0,
                          right: 50.0,
                          bottom: 50.0,
                          top: 30.0,
                        ),
                        child: Consumer<AddParkingSpaceViewModel>(
                          builder: (context, value, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'name',
                                      newValue,
                                    );
                                  },
                                  title: '** Parking Space Name',
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'address_line_one',
                                      newValue,
                                    );
                                  },
                                  title: '** Address (Line 1)',
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'address_line_two',
                                      newValue,
                                    );
                                  },
                                  title: 'Address (Line 2)',
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'city',
                                      newValue,
                                    );
                                  },
                                  title: '** City',
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'state_province',
                                      newValue,
                                    );
                                  },
                                  title: '** Province/State',
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'country',
                                      newValue,
                                    );
                                  },
                                  title: '** Country',
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'postal_code',
                                      newValue,
                                    );
                                  },
                                  title: '** Postal Code',
                                ),
                                const Text('Photo of Parking Space:'),
                                const Text(
                                  '** Make sure developer can see your parking layout',
                                  style: kTextStyle,
                                ),
                                const SizedBox(height: 20.0),
                                SubmitButton(title: 'Upload', onPressed: () {}),
                                // const SizedBox(height: 20.0),
                                // SubmitButton(title: 'Upload', onPressed: () {}),
                                // const SizedBox(height: 20.0),
                                // SubmitButton(title: 'Upload', onPressed: () {}),
                                // const SizedBox(height: 20.0),
                                // TextButton(
                                //   onPressed: () {},
                                //   child: Text(
                                //     '+ Add more photo',
                                //     style: kTextStyle.copyWith(
                                //       color: const Color(0xFFE85A2A),
                                //       fontSize: 12.0,
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  'Motorcycle spot price:',
                                  style: kTextStyle,
                                ),
                                const SizedBox(height: 5.0),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'motorcycle_price',
                                    newValue,
                                  );
                                }, title: 'RM  | '),
                                const Text(
                                  'Car spot price:',
                                  style: kTextStyle,
                                ),
                                const SizedBox(height: 5.0),
                                ShadowTextField((newValue) {
                                  value.handleChange(
                                    'car_price',
                                    newValue,
                                  );
                                }, title: 'RM  | '),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: value.isChecked,
                                      onChanged: (newValue) {
                                        value.setIsChecked(newValue!);
                                      },
                                    ),
                                    Flexible(
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              '** By adding a parking space, you agree to our ',
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
                                Center(
                                  child: SubmitButton(
                                    title: 'Add',
                                    onPressed: () {
                                      handleSubmit();
                                    },
                                  ),
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
