import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/loading.dart';
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
  late bool isParkingLayoutEmpty = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dynamic id = ModalRoute.of(context)!.settings.arguments;
      getParkingSpaceDetails(id.toString());
    });
  }

  getParkingSpaceDetails(String id) async {
    await Provider.of<AddBookingViewModel>(context, listen: false)
        .getParkingSpaceDetail(id);
  }

  handleSubmit() async {
    AddBookingViewModel addBookingViewModel = AddBookingViewModel();
    FormatDate formatDate = FormatDate();

    DateTime timeFrom = formatDate.parseDateTime(
      Provider.of<TimeProvider>(context, listen: false).date,
      Provider.of<TimeProvider>(context, listen: false).from['hour'],
      Provider.of<TimeProvider>(context, listen: false).from['minute'],
    );

    DateTime timeTo = formatDate.parseDateTime(
      Provider.of<TimeProvider>(context, listen: false).date,
      Provider.of<TimeProvider>(context, listen: false).to['hour'],
      Provider.of<TimeProvider>(context, listen: false).to['minute'],
    );

    Map<String, dynamic> data = {
      'is_purchased': false,
      'time_from': timeFrom.toString(),
      'time_to': timeTo.toString(),
      'parking_space_id': Provider.of<AddBookingViewModel>(
        context,
        listen: false,
      ).parkingSpaceDetails!.id,
      'total_car':
          Provider.of<AddBookingViewModel>(context, listen: false).carCount,
      'total_motorcycle':
          Provider.of<AddBookingViewModel>(context, listen: false)
              .motorcycleCount,
      'total_price':
          (Provider.of<AddBookingViewModel>(context, listen: false).carCount *
                  Provider.of<AddBookingViewModel>(
                    context,
                    listen: false,
                  ).parkingSpaceDetails!.parkingLayout!.carPrice!) +
              (Provider.of<AddBookingViewModel>(
                    context,
                    listen: false,
                  ).motorcycleCount *
                  Provider.of<AddBookingViewModel>(
                    context,
                    listen: false,
                  ).parkingSpaceDetails!.parkingLayout!.motorcyclePrice!),
      'parking_spot': Provider.of<AddBookingViewModel>(
        context,
        listen: false,
      ).selectedPosition.toList(),
    };

    if (Provider.of<AddBookingViewModel>(
      context,
      listen: false,
    ).selectedPosition.isNotEmpty) {
      await addBookingViewModel.submitAddBooking(context, data);
    }

    setState(() {
      isParkingLayoutEmpty = !isParkingLayoutEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Provider.of<AddBookingViewModel>(context).isLoading
              ? const LoadingScreen()
              : Column(
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
                        child: Consumer<AddBookingViewModel>(
                          builder: (context, value, child) {
                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: NetworkImage(
                                    value
                                        .parkingSpaceDetails!.imageDownloadUrl!,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  value.parkingSpaceDetails!.name!,
                                  style: kTitleTextStyle,
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  '${value.parkingSpaceDetails!.addressLineOne}, ${value.parkingSpaceDetails!.addressLineTwo}, ${value.parkingSpaceDetails!.postalCode}, ${value.parkingSpaceDetails!.city}, ${value.parkingSpaceDetails!.stateProvince}, ${value.parkingSpaceDetails!.country}',
                                  style: kTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20.0),
                              ],
                            );
                          },
                        )),
                    SizedBox(
                      width: width / 1.3,
                      child: Column(
                        children: [
                          Text(
                            'Select Date',
                            style:
                                kTitleTextStyle.copyWith(color: kPrimaryColor),
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
                                    Provider.of<TimeProvider>(context,
                                            listen: false)
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
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.transparent),
                              shadowColor: MaterialStatePropertyAll<Color>(
                                  Colors.transparent),
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
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.transparent),
                              shadowColor: MaterialStatePropertyAll<Color>(
                                  Colors.transparent),
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
                    Consumer<AddBookingViewModel>(
                      builder: (context, value, child) {
                        return ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isParkingLayoutEmpty = false;
                            });
                            final result = await Navigator.pushNamed(
                              context,
                              ParkingLayoutScreen.id,
                              arguments: {
                                "parkingLayoutId": value
                                    .parkingSpaceDetails!.parkingLayout!.id,
                                "isEditable": true,
                                "selectedPosition": value.selectedPosition,
                                "carCount": value.carCount,
                                "motorcycleCount": value.motorcycleCount,
                              },
                            );
                            value.setSelectedPosition(
                              (result as Map)['selectedPosition']
                                  as Set<String>,
                            );
                            value.setCarCount(
                              result['carCount'] as int,
                            );
                            value.setMotorcycleCount(
                              result['motorcycleCount'] as int,
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
                              'Select Parking Layout',
                              style: kTextStyle.copyWith(
                                fontSize: 13.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
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
