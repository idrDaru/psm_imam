import 'package:flutter/material.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/submit_button.dart';
import 'package:psm_imam/views/payment_form_screen/payment_form_screen.dart';

class PaymentMethodScreen extends StatelessWidget {
  static String id = 'payment_method_screen';
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Choose Payment Method',
                style: kTitleTextStyle.copyWith(
                  color: kPrimaryColor,
                  fontSize: 40.0,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Choose payment method suitable for you',
                style: kTextStyle,
              ),
              const SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {},
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
                  height: 80.0,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.0,
                          width: 100.0,
                          child:
                              Image.asset('assets/images/Master-Card-Logo.png'),
                        ),
                        const SizedBox(width: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '**** **** **** 1234',
                              style: kTextStyle.copyWith(
                                fontSize: 20.0,
                              ),
                            ),
                            const Text(
                              'Expires 09/26',
                              style: kTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {},
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
                  height: 80.0,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.0,
                          width: 100.0,
                          child: Image.asset('assets/images/Visa-Logo.png'),
                        ),
                        const SizedBox(width: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '**** **** **** 1234',
                              style: kTextStyle.copyWith(
                                fontSize: 20.0,
                              ),
                            ),
                            const Text(
                              'Expires 01/25',
                              style: kTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.transparent),
                  shadowColor:
                      MaterialStatePropertyAll<Color>(Colors.transparent),
                  padding: MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.all(0),
                  ),
                ),
                onPressed: () {},
                child: Container(
                  height: 80.0,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.0,
                          width: 100.0,
                          child: Image.asset('assets/images/Paypal-Logo.png'),
                        ),
                        const SizedBox(width: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'rismi@graduate.utm.my',
                              style: kTextStyle.copyWith(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              Center(
                child: SubmitButton(
                  title: 'Add Payment Method',
                  onPressed: () {
                    Navigator.pushNamed(context, PaymentFormScreen.id);
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
