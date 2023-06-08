import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/components/parking_layout.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/view_models/parking_layout_view_model.dart';

class ParkingLayoutScreen extends StatefulWidget {
  static String id = 'parking_layout_screen';
  const ParkingLayoutScreen({super.key});

  @override
  State<ParkingLayoutScreen> createState() => _ParkingLayoutScreenState();
}

class _ParkingLayoutScreenState extends State<ParkingLayoutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dynamic args = ModalRoute.of(context)!.settings.arguments;
      getParkingLayout(
        args['parkingLayoutId'].toString(),
        args['isEditable'],
        args['selectedPosition'],
        args['carCount'],
        args['motorcycleCount'],
      );
    });
  }

  getParkingLayout(
    String id,
    bool isEditable,
    Set<String> selectedPosition,
    int carCount,
    int motorcycleCount,
  ) async {
    Provider.of<ParkingLayoutViewModel>(
      context,
      listen: false,
    ).setIsEditable(isEditable);
    await Provider.of<ParkingLayoutViewModel>(
      context,
      listen: false,
    ).getParkingLayout(
      id,
      selectedPosition,
      carCount,
      motorcycleCount,
    );
  }

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
        body: Provider.of<ParkingLayoutViewModel>(context).isLoading
            ? const LoadingScreen()
            : SingleChildScrollView(
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
                      const ParkingLayoutComponent(),
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
                      Consumer<ParkingLayoutViewModel>(
                        builder: (context, value, child) {
                          return value.isEditable
                              ? Center(
                                  child: SubmitButton(
                                    title: 'Select',
                                    onPressed: () {
                                      Navigator.pop(
                                        context,
                                        <String, dynamic>{
                                          "selectedPosition":
                                              value.selectedPosition,
                                          "carCount": value.carCount,
                                          "motorcycleCount":
                                              value.motorcycleCount,
                                        },
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
