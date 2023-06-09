import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/providers/time_provider.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/view_models/add_booking_view_model.dart';
import 'package:psm_imam/view_models/add_parking_space_view_model.dart';
import 'package:psm_imam/view_models/edit_booking_view_model.dart';
import 'package:psm_imam/view_models/edit_parking_space_view_model.dart';
import 'package:psm_imam/view_models/edit_profile_view_model.dart';
import 'package:psm_imam/view_models/home_view_model.dart';
import 'package:psm_imam/view_models/login_view_model.dart';
import 'package:psm_imam/view_models/manage_booking_view_model.dart';
import 'package:psm_imam/view_models/manage_parking_space_view_model.dart';
import 'package:psm_imam/view_models/parking_layout_view_model.dart';
import 'package:psm_imam/view_models/parking_location_view_model.dart';
import 'package:psm_imam/view_models/profile_view_model.dart';
import 'package:psm_imam/view_models/provider_registration_view_model.dart';
import 'package:psm_imam/view_models/user_registration_view_model.dart';
import 'package:psm_imam/views/add_booking_screen/index.dart';
import 'package:psm_imam/views/add_parking_space_screen/index.dart';
import 'package:psm_imam/views/edit_booking_screen/index.dart';
import 'package:psm_imam/views/edit_parking_space_screen/index.dart';
import 'package:psm_imam/views/edit_profile_screen/index.dart';
import 'package:psm_imam/views/home_screen/index.dart';
import 'package:psm_imam/views/login_screen/index.dart';
import 'package:psm_imam/views/manage_booking_screen/index.dart';
import 'package:psm_imam/views/manage_parking_space_screen/index.dart';
import 'package:psm_imam/views/mock_external_payment_screen.index.dart';
import 'package:psm_imam/views/parking_layout_screen/index.dart';
import 'package:psm_imam/views/parking_location_screen/index.dart';
import 'package:psm_imam/views/payment_form_screen/index.dart';
import 'package:psm_imam/views/payment_method_screen/index.dart';
import 'package:psm_imam/views/payment_screen/index.dart';
import 'package:psm_imam/views/profile_screen/index.dart';
import 'package:psm_imam/views/registrations_screen/provider_registration_screen.dart';
import 'package:psm_imam/views/registrations_screen/user_registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        LoginScreen.id: (context) => ChangeNotifierProvider(
              create: (context) => LoginViewModel(),
              child: const LoginScreen(),
            ),
        UserRegistrationScreen.id: (context) => ChangeNotifierProvider(
              create: (context) => UserRegistrationViewModel(),
              child: const UserRegistrationScreen(),
            ),
        ProviderRegistrationScreen.id: (context) => ChangeNotifierProvider(
              create: (context) => ProviderRegistrationViewModel(),
              child: const ProviderRegistrationScreen(),
            ),

        // PARKING SPACE MANAGEMENT ROUTES
        AddParkingSpaceScreen.id: (context) => ChangeNotifierProvider(
              create: (context) => AddParkingSpaceViewModel(),
              child: const AddParkingSpaceScreen(),
            ),
        EditParkingSpaceScreen.id: (context) => ChangeNotifierProvider(
              create: (context) => EditParkingSpaceViewModel(),
              child: const EditParkingSpaceScreen(),
            ),
        ManageParkingSpaceScreen.id: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => UserProvider(),
                ),
                ChangeNotifierProvider(
                  create: (context) => ManageParkingSpaceViewModel(),
                ),
              ],
              child: const ManageParkingSpaceScreen(),
            ),
        ParkingLayoutScreen.id: (context) => ChangeNotifierProvider(
              create: (context) => ParkingLayoutViewModel(),
              child: const ParkingLayoutScreen(),
            ),
        ParkingLocationScreen.id: (context) => ChangeNotifierProvider(
              create: (context) => ParkingLocationViewModel(),
              child: const ParkingLocationScreen(),
            ),

        // ACCOUNT MANAGEMENT ROUTES
        ProfileScreen.id: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ProfileViewModel(),
                ),
                ChangeNotifierProvider(
                  create: (context) => UserProvider(),
                ),
              ],
              child: const ProfileScreen(),
            ),
        EditProfileScreen.id: (context) => ChangeNotifierProvider(
              create: (context) => EditProfileViewModel(),
              child: const EditProfileScreen(),
            ),

        // MANAGE BOOKING SCREEN
        AddBookingScreen.id: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => AddBookingViewModel(),
                ),
                ChangeNotifierProvider(
                  create: (context) => TimeProvider(),
                ),
              ],
              child: const AddBookingScreen(),
            ),
        ManageBookingScreen.id: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => ManageBookingViewModel(),
                ),
                ChangeNotifierProvider(
                  create: (context) => UserProvider(),
                ),
              ],
              child: const ManageBookingScreen(),
            ),
        EditBookingScreen.id: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => EditBookingViewModel(),
                ),
                ChangeNotifierProvider(
                  create: (context) => TimeProvider(),
                ),
              ],
              child: const EditBookingScreen(),
            ),

        // PAYMENT SCREEN
        PaymentFormScreen.id: (context) => const PaymentFormScreen(),
        PaymentMethodScreen.id: (context) => const PaymentMethodScreen(),
        PaymentScreen.id: (context) => const PaymentScreen(),
        MockExternalPaymentScreen.id: (context) =>
            const MockExternalPaymentScreen(),

        // HOME SCREEN
        HomeScreen.id: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => HomeViewModel(),
                ),
                ChangeNotifierProvider(
                  create: (context) => UserProvider(),
                ),
              ],
              child: const HomeScreen(),
            ),
      },
    );
  }
}
