import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';

class EditParkingSpaceScreen extends StatefulWidget {
  static String id = 'edit_parking_space_screen';
  const EditParkingSpaceScreen({super.key});

  @override
  State<EditParkingSpaceScreen> createState() => _EditParkingSpaceScreenState();
}

class _EditParkingSpaceScreenState extends State<EditParkingSpaceScreen> {
  bool isChecked = false;
  String car_spot_price = '', motorcycle_spot_price = '';

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
              const Header(title: 'Edit Parking Space'),
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
                      // const ShadowTextField(title: 'Fakulti Alam Bina dan Ukur'),
                      // const ShadowTextField(title: 'Fakulti Alam Bina dan Ukur,'),
                      // const ShadowTextField(title: 'Lingkaran Ilmu, UTM'),
                      // const ShadowTextField(title: 'Johor Bahru'),
                      // const ShadowTextField(title: 'Johor'),
                      // const ShadowTextField(title: 'Malaysia'),
                      // const ShadowTextField(title: '81310'),
                      const Text('Photo of Parking Space:'),
                      const Text(
                        '** Make sure developer can see your parking layout',
                        style: kTextStyle,
                      ),
                      const SizedBox(height: 20.0),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubmitButton(title: 'Upload', onPressed: () {}),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Photo1.jpg'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubmitButton(title: 'Upload', onPressed: () {}),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Photo2.jpg'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubmitButton(title: 'Upload', onPressed: () {}),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Photo3.jpg'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
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
                      // ShadowTextField((value) {
                      //   return motorcycle_spot_price = value;
                      // }, title: 'RM  | 0.50'),
                      const Text(
                        'Car spot price (optional)',
                        style: kTextStyle,
                      ),
                      const SizedBox(height: 5.0),
                      // ShadowTextField((value) {
                      //   return car_spot_price = value;
                      // }, title: 'RM  | 1.00'),
                      const SizedBox(height: 20.0),
                      Center(
                        child: SubmitButton(
                          title: 'Save',
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
      ),
    );
  }
}
