import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/providers/booking_provider.dart';
import 'package:psm_imam/providers/parking_space_provider.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/views/add_booking_screen/index.dart';
import 'package:psm_imam/views/add_parking_space_screen/index.dart';
import 'package:psm_imam/views/edit_booking_screen/index.dart';
import 'package:psm_imam/views/edit_parking_space_screen/index.dart';
import 'package:psm_imam/views/edit_profile_screen/index.dart';
import 'package:psm_imam/views/home_screen/index.dart';
import 'package:psm_imam/views/login_screen/index.dart';
import 'package:psm_imam/views/manage_booking_screen/index.dart';
import 'package:psm_imam/views/manage_parking_space_screen/index.dart';
import 'package:psm_imam/views/parking_layout_screen/index.dart';
import 'package:psm_imam/views/payment_form_screen/index.dart';
import 'package:psm_imam/views/payment_method_screen/index.dart';
import 'package:psm_imam/views/profile_screen/index.dart';
import 'package:psm_imam/views/registrations_screen/provider_registration_screen.dart';
import 'package:psm_imam/views/registrations_screen/user_registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.id,
      routes: {
        // AUTHENTICATION ROUTES
        LoginScreen.id: (context) => const LoginScreen(),
        UserRegistrationScreen.id: (context) => const UserRegistrationScreen(),
        ProviderRegistrationScreen.id: (context) =>
            const ProviderRegistrationScreen(),

        // PARKING SPACE MANAGEMENT ROUTES
        AddParkingSpaceScreen.id: (context) => const AddParkingSpaceScreen(),
        EditParkingSpaceScreen.id: (context) => const EditParkingSpaceScreen(),
        ManageParkingSpaceScreen.id: (context) =>
            const ManageParkingSpaceScreen(),
        ParkingLayoutScreen.id: (context) => const ParkingLayoutScreen(),

        // ACCOUNT MANAGEMENT ROUTES
        ProfileScreen.id: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => UserProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ParkingSpaceProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => BookingProvider(),
                )
              ],
              child: const ProfileScreen(),
            ),
        EditProfileScreen.id: (context) => ChangeNotifierProvider(
              create: (context) => UserProvider(),
              child: const EditProfileScreen(),
            ),

        // MANAGE BOOKING SCREEN
        AddBookingScreen.id: (context) => const AddBookingScreen(),
        ManageBookingScreen.id: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => UserProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => BookingProvider(),
                ),
              ],
              child: const ManageBookingScreen(),
            ),
        EditBookingScreen.id: (context) => const EditBookingScreen(),

        // PAYMENT SCREEN
        PaymentFormScreen.id: (context) => const PaymentFormScreen(),
        PaymentMethodScreen.id: (context) => const PaymentMethodScreen(),

        // HOME SCREEN
        HomeScreen.id: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                    create: (context) => ParkingSpaceProvider()),
                ChangeNotifierProvider(create: (context) => UserProvider()),
              ],
              child: const HomeScreen(),
            ),
        // HomeScreen.id: (context) => ChangeNotifierProvider(
        //       create: (context) => UserProvider(),
        //       child: const HomeScreen(),
        //     ),
      },
    );
  }
}
