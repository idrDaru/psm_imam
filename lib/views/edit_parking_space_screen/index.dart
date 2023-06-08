import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/view_models/edit_parking_space_view_model.dart';
import 'package:psm_imam/views/manage_parking_space_screen/index.dart';

class EditParkingSpaceScreen extends StatefulWidget {
  static String id = 'edit_parking_space_screen';
  const EditParkingSpaceScreen({super.key});

  @override
  State<EditParkingSpaceScreen> createState() => _EditParkingSpaceScreenState();
}

class _EditParkingSpaceScreenState extends State<EditParkingSpaceScreen> {
  bool isChecked = false;
  String carSpotPrice = '', motorcycleSpotPrice = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dynamic id = ModalRoute.of(context)!.settings.arguments;
      getParkingSpace(id.toString());
    });
  }

  getParkingSpace(String id) async {
    Provider.of<EditParkingSpaceViewModel>(
      context,
      listen: false,
    ).getParkingSpace(id);
  }

  handleSubmit() async {
    Response response = await Provider.of<EditParkingSpaceViewModel>(
      context,
      listen: false,
    ).handleSubmitEditParkingSpace(
      Provider.of<EditParkingSpaceViewModel>(
        context,
        listen: false,
      ).parkingSpace!.id!,
    );

    var decodeResponse = jsonDecode(response.body);
    if (decodeResponse['status'] == 200) {
      Navigator.pushReplacementNamed(context, ManageParkingSpaceScreen.id);
    } else {
      print(decodeResponse['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Provider.of<EditParkingSpaceViewModel>(context).isLoading
            ? const LoadingScreen()
            : SingleChildScrollView(
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
                        child: Consumer<EditParkingSpaceViewModel>(
                          builder: (context, value, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'name',
                                      newValue,
                                    );
                                  },
                                  title: value.parkingSpace!.name!,
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'address_line_one',
                                      newValue,
                                    );
                                  },
                                  title: value.parkingSpace!.addressLineOne!,
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'address_line_two',
                                      newValue,
                                    );
                                  },
                                  title: value.parkingSpace!.addressLineTwo!,
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'city',
                                      newValue,
                                    );
                                  },
                                  title: value.parkingSpace!.city!,
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'state_province',
                                      newValue,
                                    );
                                  },
                                  title: value.parkingSpace!.stateProvince!,
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'country',
                                      newValue,
                                    );
                                  },
                                  title: value.parkingSpace!.country!,
                                ),
                                ShadowTextField(
                                  (newValue) {
                                    value.handleChange(
                                      'postal_code',
                                      newValue,
                                    );
                                  },
                                  title: value.parkingSpace!.postalCode!,
                                ),
                                const Text('Photo of Parking Space:'),
                                const Text(
                                  '** Make sure developer can see your parking layout',
                                  style: kTextStyle,
                                ),
                                const SizedBox(height: 20.0),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SubmitButton(
                                            title: 'Upload', onPressed: () {}),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text('Photo1.jpg'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SubmitButton(
                                            title: 'Upload', onPressed: () {}),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text('Photo2.jpg'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SubmitButton(
                                            title: 'Upload', onPressed: () {}),
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
                                ShadowTextField(
                                  (newValue) {},
                                  title:
                                      'RM  | ${value.parkingSpace!.parkingLayout!.motorcyclePrice}',
                                ),
                                const Text(
                                  'Car spot price (optional)',
                                  style: kTextStyle,
                                ),
                                const SizedBox(height: 5.0),
                                ShadowTextField(
                                  (newValue) {},
                                  title:
                                      'RM  | ${value.parkingSpace!.parkingLayout!.carPrice}',
                                ),
                                const SizedBox(height: 20.0),
                                Center(
                                  child: SubmitButton(
                                    title: 'Save',
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
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
