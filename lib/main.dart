import 'package:flutter/material.dart';
import 'package:psm_imam/views/add_parking_space_screen/add_parking_space_screen.dart';
import 'package:psm_imam/views/edit_booking_screen/edit_booking_screen.dart';
import 'package:psm_imam/views/edit_parking_space_screen/edit_parking_space_screen.dart';
import 'package:psm_imam/views/edit_profile_screen/provider_edit_profile_screen.dart';
import 'package:psm_imam/views/edit_profile_screen/user_edit_profile_screen.dart';
import 'package:psm_imam/views/home_screen/home_screen.dart';
import 'package:psm_imam/views/login_screen/login_screen.dart';
import 'package:psm_imam/views/manage_booking_screen/manage_booking_screen.dart';
import 'package:psm_imam/views/manage_parking_space_screen/manage_parking_space_screen.dart';
import 'package:psm_imam/views/payment_form_screen/payment_form_screen.dart';
import 'package:psm_imam/views/payment_method_screen/payment_method_screen.dart';
import 'package:psm_imam/views/profile_screen/provider_profile_screen.dart';
import 'package:psm_imam/views/profile_screen/user_profile_screen.dart';
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

        // ACCOUNT MANAGEMENT ROUTES
        UserProfileScreen.id: (context) => const UserProfileScreen(),
        ProviderProfileScreen.id: (context) => const ProviderProfileScreen(),
        UserEditProfileScreen.id: (context) => const UserEditProfileScreen(),
        ProviderEditProfileScreen.id: (context) =>
            const ProviderEditProfileScreen(),

        // MANAGE BOOKING SCREEN
        ManageBookingScreen.id: (context) => const ManageBookingScreen(),
        EditBookingScreen.id: (context) => const EditBookingScreen(),

        // PAYMENT SCREEN
        PaymentFormScreen.id: (context) => const PaymentFormScreen(),
        PaymentMethodScreen.id: (context) => const PaymentMethodScreen(),

        // HOME SCREEN
        HomeScreen.id: (context) => const HomeScreen(),
      },
    );
  }
}
