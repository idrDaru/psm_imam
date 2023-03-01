import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/header.dart';
import 'package:psm_imam/views/components/shadow_text_field.dart';
import 'package:psm_imam/views/components/submit_button.dart';

class AddParkingSpaceScreen extends StatefulWidget {
  static String id = 'add_parking_space_screen';
  const AddParkingSpaceScreen({super.key});

  @override
  State<AddParkingSpaceScreen> createState() => _AddParkingSpaceScreenState();
}

class _AddParkingSpaceScreenState extends State<AddParkingSpaceScreen> {
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
            const Header(title: 'Add Parking Space'),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  bottom: 50.0,
                  top: 30.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShadowTextField(title: 'Parking Space Name'),
                    const ShadowTextField(title: 'Address (Line 1)'),
                    const ShadowTextField(title: 'Address (Line 2) - Optional'),
                    const ShadowTextField(title: 'City'),
                    const ShadowTextField(title: 'Province/State'),
                    const ShadowTextField(title: 'Country'),
                    const ShadowTextField(title: 'Postal Code'),
                    const Text('Photo of Parking Space:'),
                    const Text(
                      '** Make sure developer can see your parking layout',
                      style: kTextStyle,
                    ),
                    const SizedBox(height: 20.0),
                    SubmitButton(title: 'Upload', onPressed: () {}),
                    const SizedBox(height: 20.0),
                    SubmitButton(title: 'Upload', onPressed: () {}),
                    const SizedBox(height: 20.0),
                    SubmitButton(title: 'Upload', onPressed: () {}),
                    const SizedBox(height: 20.0),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '+ Add more photo',
                        style: kTextStyle.copyWith(
                          color: const Color(0xFFE85A2A),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Motorcycle spot price (optional):',
                      style: kTextStyle,
                    ),
                    const SizedBox(height: 5.0),
                    const ShadowTextField(title: 'RM  | '),
                    const Text(
                      'Car spot price (optional)',
                      style: kTextStyle,
                    ),
                    const SizedBox(height: 5.0),
                    const ShadowTextField(title: 'RM  | '),
                    const SizedBox(height: 20.0),
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
                                  'By adding a parking space, you agree to our ',
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
                        onPressed: () {},
                      ),
                    ),
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
