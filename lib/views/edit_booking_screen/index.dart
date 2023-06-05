import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:psm_imam/views/parking_layout_screen/index.dart';

class EditBookingScreen extends StatefulWidget {
  static String id = 'edit_booking_screen';
  const EditBookingScreen({super.key});

  @override
  State<EditBookingScreen> createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  DateTime currentDate = DateTime.now();

  handleChange() {}

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const Header(title: 'Edit Booking'),
                  AppBar(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        args.parkingSpace.imageDownloadUrl,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      args.parkingSpace.name,
                      style: kTitleTextStyle,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      '${args.parkingSpace.addressLineOne}, ${args.parkingSpace.addressLineTwo}, ${args.parkingSpace.postalCode}, ${args.parkingSpace.city}, ${args.parkingSpace.stateProvince}, ${args.parkingSpace.country}',
                      style: kTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              SizedBox(
                width: width / 1.3,
                child: Column(
                  children: [
                    Text(
                      'Select New Date',
                      style: kTitleTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: CalendarCarousel(
                        height: 350,
                        selectedDateTime: currentDate,
                        selectedDayButtonColor: kPrimaryColor,
                        todayButtonColor: Colors.transparent,
                        todayTextStyle: TextStyle(
                          color: currentDate.day == DateTime.now().day
                              ? Colors.white
                              : Colors.black,
                        ),
                        minSelectedDate: DateTime.now().subtract(
                          const Duration(days: 1),
                        ),
                        headerTextStyle: kTitleTextStyle.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                        iconColor: kPrimaryColor,
                        weekendTextStyle: const TextStyle(
                          color: Colors.red,
                        ),
                        onDayPressed: (p0, p1) {
                          setState(() {
                            currentDate = p0;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //       isScrollControlled: true,
                    //       context: context,
                    //       builder: (context) => SingleChildScrollView(
                    //         child: Container(
                    //           padding: EdgeInsets.only(
                    //             bottom:
                    //                 MediaQuery.of(context).viewInsets.bottom,
                    //           ),
                    //           child: TimeDropdown(
                    //             type: 'from',
                    //             callback: handleChange(),
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   style: const ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStatePropertyAll<Color>(Colors.transparent),
                    //     shadowColor:
                    //         MaterialStatePropertyAll<Color>(Colors.transparent),
                    //     padding: MaterialStatePropertyAll<EdgeInsets>(
                    //       EdgeInsets.all(0),
                    //     ),
                    //   ),
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         width: 0.5,
                    //         color: Colors.black12,
                    //       ),
                    //       boxShadow: const [
                    //         BoxShadow(
                    //           color: Colors.black26,
                    //           blurRadius: 5,
                    //           offset: Offset(0, 5),
                    //         )
                    //       ],
                    //     ),
                    //     child: Container(
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 20.0,
                    //         vertical: 10.0,
                    //       ),
                    //       color: Colors.white,
                    //       child: Text(
                    //         'From',
                    //         style: kTextStyle.copyWith(
                    //           color: Colors.grey,
                    //           fontSize: 17.0,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20.0),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //       isScrollControlled: true,
                    //       context: context,
                    //       builder: (context) => SingleChildScrollView(
                    //         child: Container(
                    //           padding: EdgeInsets.only(
                    //             bottom:
                    //                 MediaQuery.of(context).viewInsets.bottom,
                    //           ),
                    //           child: TimeDropdown(
                    //             type: 'to',
                    //             callback: handleChange(),
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   style: const ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStatePropertyAll<Color>(Colors.transparent),
                    //     shadowColor:
                    //         MaterialStatePropertyAll<Color>(Colors.transparent),
                    //     padding: MaterialStatePropertyAll<EdgeInsets>(
                    //       EdgeInsets.all(0),
                    //     ),
                    //   ),
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         width: 0.5,
                    //         color: Colors.black12,
                    //       ),
                    //       boxShadow: const [
                    //         BoxShadow(
                    //           color: Colors.black26,
                    //           blurRadius: 5,
                    //           offset: Offset(0, 5),
                    //         )
                    //       ],
                    //     ),
                    //     child: Container(
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 20.0,
                    //         vertical: 10.0,
                    //       ),
                    //       color: Colors.white,
                    //       child: Text(
                    //         'To',
                    //         style: kTextStyle.copyWith(
                    //           color: Colors.grey,
                    //           fontSize: 17.0,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20.0),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ParkingLayoutScreen.id,
                    arguments: args.parkingSpace.parkingLayout,
                  );
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    kSecondaryColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Change Parking Layout',
                    style: kTextStyle.copyWith(
                      fontSize: 13.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              SubmitButton(
                title: 'Save',
                onPressed: () {},
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
