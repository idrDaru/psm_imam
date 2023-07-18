import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/helpers/format_date.dart';
import 'package:psm_imam/view_models/parking_space_summary_view_model.dart';

class ParkingSpaceSummaryScreen extends StatefulWidget {
  static String id = 'parking_space_summary';
  const ParkingSpaceSummaryScreen({super.key});

  @override
  State<ParkingSpaceSummaryScreen> createState() =>
      _ParkingSpaceSummaryScreenState();
}

class _ParkingSpaceSummaryScreenState extends State<ParkingSpaceSummaryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dynamic id = ModalRoute.of(context)!.settings.arguments;
      getParkingSpace(id);
    });
  }

  getParkingSpace(String id) async {
    Provider.of<ParkingSpaceSummaryViewModel>(
      context,
      listen: false,
    ).getParkingSpace(id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Provider.of<ParkingSpaceSummaryViewModel>(context).isLoading
            ? const LoadingScreen()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Header(title: 'Summary'),
                    Consumer<ParkingSpaceSummaryViewModel>(
                      builder: (context, value, child) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.parkingSpace!.booking!.length,
                        itemBuilder: (context, index) {
                          FormatDate formatDate = FormatDate();
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 30.0,
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 30.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              border: Border.all(
                                width: 2.0,
                                color: kSecondaryColor,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status: ${value.parkingSpace!.booking![index].isExpired! ? 'Expired' : value.parkingSpace!.booking![index].isPurchased! ? value.parkingSpace!.booking![index].isActive! ? 'Active' : 'Not Active' : 'Wait for Payment'}",
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "Total Car: ${value.parkingSpace!.booking![index].totalCar.toString()}",
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "Total Motorcycle: ${value.parkingSpace!.booking![index].totalMotorcycle.toString()}",
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "Total Price: RM ${value.parkingSpace!.booking![index].totalPrice.toString()}",
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "Booking Time: ${formatDate.displayDateTime(value.parkingSpace!.booking![index].timeFrom!, value.parkingSpace!.booking![index].timeTo!)}",
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
