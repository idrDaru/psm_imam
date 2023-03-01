import 'package:flutter/material.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/home_screen/home_screen.dart';
import 'package:psm_imam/views/manage_booking_screen/manage_booking_screen.dart';
import 'package:psm_imam/views/profile_screen/user_profile_screen.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer();
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
  );
}

Widget buildMenuItems(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      top: 50.0,
    ),
    child: Wrap(
      runSpacing: 16.0,
      children: [
        ListTile(
          leading: Image(
            image: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/194/194938.png',
            ),
          ),
          title: Flexible(
            child: Text(
              'Universiti Teknologi Malaysia',
              style: kTextStyle.copyWith(
                color: kPrimaryColor,
              ),
            ),
          ),
          enabled: false,
        ),
        const Divider(color: kSecondaryColor),
        ListTile(
          leading: const Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, HomeScreen.id);
          },
        ),
        const Divider(color: kSecondaryColor),
        ListTile(
          leading: const Icon(Icons.account_circle_outlined),
          title: Text('Profile'),
          onTap: () {
            Navigator.pushNamed(context, UserProfileScreen.id);
          },
        ),
        const Divider(color: kSecondaryColor),
        ListTile(
          leading: const Icon(Icons.description_outlined),
          // leading: const Icon(Icons.feed_outlined),
          title: Text('My Bookings'),
          onTap: () {
            Navigator.pushNamed(context, ManageBookingScreen.id);
          },
        ),
        const Divider(color: kSecondaryColor),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: Text('Logout'),
          onTap: () {},
        ),
      ],
    ),
  );
}
