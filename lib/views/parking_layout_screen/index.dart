import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';

class ParkingLayoutScreen extends StatelessWidget {
  static String id = 'parking_layout_screen';
  const ParkingLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Parking Space Layout',
                  style: kTitleTextStyle.copyWith(
                    color: kPrimaryColor,
                    fontSize: 30.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Choose parking space spot suitable for you',
                  style: kTextStyle,
                ),
                const SizedBox(height: 20.0),
                Text("Selected: "),
                Center(
                  child: SubmitButton(
                    title: 'Select',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
