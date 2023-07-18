import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/custom_scaffold.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/view_models/manage_parking_space_view_model.dart';
import 'package:psm_imam/views/add_parking_space_screen/index.dart';
import 'package:psm_imam/views/edit_parking_space_screen/index.dart';
import 'package:psm_imam/views/parking_space_summary_screen/index.dart';

class ManageParkingSpaceScreen extends StatefulWidget {
  static String id = 'manage_parking_space _screen';
  const ManageParkingSpaceScreen({super.key});

  @override
  State<ManageParkingSpaceScreen> createState() =>
      _ManageParkingSpaceScreenState();
}

class _ManageParkingSpaceScreenState extends State<ManageParkingSpaceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProviderParkingSpace();
    });
  }

  getProviderParkingSpace() async {
    await Provider.of<UserProvider>(context, listen: false).getUser();
    await Provider.of<ManageParkingSpaceViewModel>(context, listen: false)
        .getProviderParkingSpaces();
  }

  handleIsActivateParkingSpace(String id, bool isActive) async {
    Map<String, dynamic> data = {
      'is_active': !isActive,
    };

    Response response = await Provider.of<ManageParkingSpaceViewModel>(
      context,
      listen: false,
    ).handleIsActiveParkingSpace(id, data);

    var decodeResponse = jsonDecode(response.body);
    if (decodeResponse['status'] == 200) {
      Navigator.pushReplacementNamed(context, ManageParkingSpaceScreen.id);
    } else {
      print("error");
    }
  }

  confirmationActivateParkingSpace(
    BuildContext context,
    String id,
    String statusWord,
    bool isActive,
  ) async {
    Widget cancelButton = SubmitButton(
      title: 'Cancel',
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget confirmButton = SubmitButton(
      title: 'Confirm',
      onPressed: () {
        Navigator.of(context).pop();
        handleIsActivateParkingSpace(id, isActive);
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text("Confirmation"),
      content: Text("Continue on $statusWord this parking space?"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold1(
      body: Provider.of<ManageParkingSpaceViewModel>(context).isLoading ||
              Provider.of<UserProvider>(context).isLoading
          ? const LoadingScreen()
          : SingleChildScrollView(
              child: Column(
                children: [
                  const Header(title: 'My Parking Spaces'),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: Provider.of<ManageParkingSpaceViewModel>(
                        context,
                        listen: false,
                      ).parkingSpace!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          height: 210.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            border: Border.all(
                              width: 2.0,
                              color: kSecondaryColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2.0,
                                                color: kSecondaryColor,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(100.0),
                                              ),
                                            ),
                                            child: Consumer<
                                                ManageParkingSpaceViewModel>(
                                              builder: (context, value, child) {
                                                return CircleAvatar(
                                                  radius: 40.0,
                                                  backgroundImage: NetworkImage(
                                                    value.parkingSpace![index]
                                                        .imageDownloadUrl
                                                        .toString(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20.0),
                                    Expanded(
                                      flex: 8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Consumer<ManageParkingSpaceViewModel>(
                                            builder: (context, value, child) =>
                                                Text(
                                              value.parkingSpace![index].name
                                                  .toString(),
                                              style: kTitleTextStyle.copyWith(
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Consumer<ManageParkingSpaceViewModel>(
                                            builder: (context, value, child) =>
                                                Text(
                                              '${value.parkingSpace![index].addressLineOne}, ${value.parkingSpace![index].addressLineTwo == null || value.parkingSpace![index].addressLineTwo == "" ? "" : "${value.parkingSpace![index].addressLineTwo}, "}${value.parkingSpace![index].postalCode} ${value.parkingSpace![index].city}, ${value.parkingSpace![index].stateProvince}, ${value.parkingSpace![index].country}',
                                              style: kTextStyle.copyWith(
                                                fontSize: 12.0,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Consumer<ManageParkingSpaceViewModel>(
                                      builder: (context, value, child) =>
                                          ElevatedButton(
                                        onPressed: () {
                                          confirmationActivateParkingSpace(
                                            context,
                                            value.parkingSpace![index].id
                                                .toString(),
                                            value.parkingSpace![index].isActive!
                                                ? 'deactivate'
                                                : 'activate',
                                            value
                                                .parkingSpace![index].isActive!,
                                          );
                                        },
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                            kSecondaryColor,
                                          ),
                                        ),
                                        child: Text(
                                          value.parkingSpace![index].isActive!
                                              ? 'Deactivate'
                                              : 'Activate',
                                          style: kTextStyle.copyWith(
                                              fontSize: 12.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Consumer<ManageParkingSpaceViewModel>(
                                      builder: (context, value, child) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              ParkingSpaceSummaryScreen.id,
                                              arguments:
                                                  value.parkingSpace![index].id,
                                            );
                                          },
                                          child: Text(
                                            'Summary',
                                            style: kTextStyle.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    kSecondaryColor),
                                          ),
                                        );
                                      },
                                    ),
                                    Consumer<ManageParkingSpaceViewModel>(
                                      builder: (context, value, child) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              EditParkingSpaceScreen.id,
                                              arguments:
                                                  value.parkingSpace![index].id,
                                            );
                                          },
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                              kPrimaryColor,
                                            ),
                                          ),
                                          child: Text(
                                            'Edit Parking Space',
                                            style: kTextStyle.copyWith(
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SubmitButton(
                    title: 'Add Parking Space',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AddParkingSpaceScreen.id,
                      );
                    },
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
    );
  }
}
