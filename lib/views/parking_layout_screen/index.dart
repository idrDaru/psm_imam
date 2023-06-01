import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/parking_layout.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/providers/parking_layout_provider.dart';

class ParkingLayoutScreen extends StatelessWidget {
  static String id = 'parking_layout_screen';
  const ParkingLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;

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
            child: ChangeNotifierProvider(
              create: (context) => ParkingLayoutProvider(),
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
                  ParkingLayout(
                    data: args,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Unavailable"),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Available"),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade300,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Selected"),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Motorcycle"),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Car"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Consumer<ParkingLayoutProvider>(
                      builder: (context, value, child) {
                        return SubmitButton(
                          title: 'Select',
                          onPressed: () {
                            Navigator.pop(context, value.selectedPosition);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
