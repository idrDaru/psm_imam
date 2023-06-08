import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/views/mock_external_payment_screen.index.dart';

class PaymentScreen extends StatelessWidget {
  static String id = 'payment_screen';
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Confirm Payment',
                  style: kTitleTextStyle.copyWith(
                    color: kPrimaryColor,
                    fontSize: 40.0,
                  ),
                ),
                const SizedBox(height: 50.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 11 / 12,
                  child: Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Parking Space Name: ${args.parkingSpace.name}',
                            style: kTextStyle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Time From: ${args.timeFrom.toString()}',
                            style: kTextStyle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Time To: ${args.timeTo.toString()}',
                            style: kTextStyle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Total Car: ${args.totalCar.toString()}',
                            style: kTextStyle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Total Motorcycle: ${args.totalMotorcycle.toString()}',
                            style: kTextStyle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Total Price: RM ${args.totalPrice.toString()}',
                            style: kTextStyle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                Center(
                  child: SubmitButton(
                    title: 'Pay',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        MockExternalPaymentScreen.id,
                        arguments: args,
                      );
                    },
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
