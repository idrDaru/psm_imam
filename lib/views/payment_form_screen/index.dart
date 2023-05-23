import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/shadow_text_field.dart';
import 'package:psm_imam/components/submit_button.dart';

class PaymentFormScreen extends StatelessWidget {
  static String id = 'payment_form_screen';
  const PaymentFormScreen({super.key});

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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Credit Card',
                  style: kTitleTextStyle.copyWith(
                    color: kPrimaryColor,
                    fontSize: 40.0,
                  ),
                ),
                const SizedBox(height: 50.0),
                // const ShadowTextField(
                //   title: 'Card Name',
                // ),
                // const ShadowTextField(
                //   title: 'Credit Card Number',
                // ),
                // Row(
                //   children: const [
                //     Expanded(
                //       child: ShadowTextField(
                //         title: 'Expires',
                //       ),
                //     ),
                //     SizedBox(width: 10.0),
                //     Expanded(
                //       child: ShadowTextField(
                //         title: 'CVV',
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 50.0),
                const Center(
                  child: Text(
                    'Debit cards are accepted at some locations and for some categories',
                    style: kTextStyle,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: Image.asset('assets/images/Master-Card-Logo.png'),
                    ),
                    SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: Image.asset('assets/images/Visa-Logo.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: SubmitButton(
                    title: 'Continue',
                    onPressed: () {},
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
