import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/services/networking.dart';
import 'package:psm_imam/views/home_screen/index.dart';

class MockExternalPaymentScreen extends StatefulWidget {
  static String id = "mock_external_payment_screen";
  const MockExternalPaymentScreen({super.key});

  @override
  State<MockExternalPaymentScreen> createState() =>
      _MockExternalPaymentScreenState();
}

class _MockExternalPaymentScreenState extends State<MockExternalPaymentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  bool isAnimationComplete = false;
  String bookingId = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dynamic args = ModalRoute.of(context)!.settings.arguments;
      bookingId = args.id;
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animationController);
    animationController.forward();
    animationController.addListener(
      () async {
        setState(() {
          isAnimationComplete = animation.isCompleted;
        });
        if (isAnimationComplete) {
          const storage = FlutterSecureStorage();
          String? token = await storage.read(key: 'access_token');
          Map<String, String> header = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          };

          Map<String, dynamic> data = {
            "is_purchased": true,
          };

          NetworkHelper networkHelper = NetworkHelper(
            endpoint: '/api/pay-booking/$bookingId',
            header: header,
            body: data,
          );

          var response = await networkHelper.putData();
          var decodeResponse = jsonDecode(response.body);
          if (decodeResponse['status'] == 200) {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(
              context,
              HomeScreen.id,
            );
          } else {
            print(decodeResponse['message']);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: !isAnimationComplete
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SpinKitCubeGrid(
                    size: 140,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "External API",
                    style: kTitleTextStyle.copyWith(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ))
            : const SizedBox.shrink(),
      ),
    );
  }
}
