import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:psm_imam/components/time_drop_down.dart';
import 'package:psm_imam/helpers/format_date.dart';
import 'package:psm_imam/providers/time_provider.dart';
import 'package:psm_imam/view_models/add_booking_view_model.dart';
import 'package:psm_imam/views/parking_layout_screen/index.dart';

class AddBookingScreen extends StatefulWidget {
  static String id = 'add_booking_screen';
  const AddBookingScreen({super.key});

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  dynamic parkingLayout;
  late String parkingSpaceId;
  late double carPrice, motorcyclePrice;
  late bool isParkingLayoutEmpty = false;

  handleSubmit() async {
    AddBookingViewModel addBookingViewModel = AddBookingViewModel();
    FormatDate formatDate = FormatDate();

    DateTime timeFrom = formatDate.formatDateTime(
      Provider.of<TimeProvider>(context, listen: false).date,
      Provider.of<TimeProvider>(context, listen: false).from['hour'],
      Provider.of<TimeProvider>(context, listen: false).from['minute'],
    );

    DateTime timeTo = formatDate.formatDateTime(
      Provider.of<TimeProvider>(context, listen: false).date,
      Provider.of<TimeProvider>(context, listen: false).to['hour'],
      Provider.of<TimeProvider>(context, listen: false).to['minute'],
    );

    Map<String, dynamic> data = {
      'is_purchased': false,
      'time_from': timeFrom.toString(),
      'time_to': timeTo.toString(),
      'parking_space_id': parkingSpaceId,
      'total_car': parkingLayout.carCount,
      'total_motorcycle': parkingLayout.motorcycleCount,
      'total_price': (parkingLayout.carCount * carPrice) +
          (parkingLayout.motorcycleCount * motorcyclePrice),
      'parking_spot': parkingLayout.selectedPosition.toList(),
    };

    if (!parkingLayout.selectedPosition.isEmpty) {
      addBookingViewModel.submitAddBooking(context, data);
    }

    setState(() {
      isParkingLayoutEmpty = !isParkingLayoutEmpty;
    });
  }

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
                  const Header(title: 'Order'),
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
                        args.imageDownloadUrl,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      args.name,
                      style: kTitleTextStyle,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      '${args.addressLineOne}, ${args.addressLineTwo}, ${args.postalCode}, ${args.city}, ${args.stateProvince}, ${args.country}',
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
                      'Select Date',
                      style: kTitleTextStyle.copyWith(color: kPrimaryColor),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Consumer<TimeProvider>(
                        builder: (context, value, child) {
                          return CalendarCarousel(
                            height: 350,
                            selectedDateTime: value.date,
                            selectedDayButtonColor: kPrimaryColor,
                            todayButtonColor: Colors.transparent,
                            todayTextStyle: TextStyle(
                              color: value.date.day == DateTime.now().day
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
                              Provider.of<TimeProvider>(context, listen: false)
                                  .setDate(p0);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "FROM",
                      style: kTitleTextStyle,
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return ListenableProvider.value(
                              value: Provider.of<TimeProvider>(context),
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: const TimeDropdown(
                                    type: 'from',
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.transparent),
                        shadowColor:
                            MaterialStatePropertyAll<Color>(Colors.transparent),
                        padding: MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.all(0),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: Colors.black12,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            )
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          color: Colors.white,
                          child: Consumer<TimeProvider>(
                            builder: (context, value, child) {
                              return Text(
                                '${value.from['hour']}:${value.from['minute']}',
                                style: kTextStyle.copyWith(
                                  color: Colors.grey,
                                  fontSize: 17.0,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "TO",
                      style: kTitleTextStyle,
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return ListenableProvider.value(
                              value: Provider.of<TimeProvider>(context),
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: const TimeDropdown(
                                    type: 'to',
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.transparent),
                        shadowColor:
                            MaterialStatePropertyAll<Color>(Colors.transparent),
                        padding: MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.all(0),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: Colors.black12,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            )
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          color: Colors.white,
                          child: Consumer<TimeProvider>(
                            builder: (context, value, child) {
                              return Text(
                                '${value.to['hour']}:${value.to['minute']}',
                                style: kTextStyle.copyWith(
                                  color: Colors.grey,
                                  fontSize: 17.0,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    ParkingLayoutScreen.id,
                    arguments: {
                      "parkingLayout": args.parkingLayout,
                      "isEditable": true,
                    },
                  );
                  setState(() {
                    parkingSpaceId = args.id.toString();
                    carPrice = args.parkingLayout.carPrice;
                    motorcyclePrice = args.parkingLayout.motorcyclePrice;
                    parkingLayout = result;
                  });
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    kSecondaryColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select Parking Layout',
                    style: kTextStyle.copyWith(
                      fontSize: 13.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              isParkingLayoutEmpty
                  ? const Text("Please select parking layout")
                  : const SizedBox.shrink(),
              const SizedBox(height: 50.0),
              SubmitButton(
                title: 'Save',
                onPressed: () {
                  handleSubmit();
                },
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
