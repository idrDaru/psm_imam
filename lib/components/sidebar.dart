import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/models/parking_user.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/views/home_screen/index.dart';
import 'package:psm_imam/views/login_screen/index.dart';
import 'package:psm_imam/views/manage_booking_screen/index.dart';
import 'package:psm_imam/views/profile_screen/index.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, child) {
      return NavigationDrawer();
    });
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
            Consumer(builder: (context, value, child) {
              return buildMenuItems(context);
            })
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
          leading: Consumer<UserProvider>(builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                value.user.user.imageDownloadURL,
              ),
            );
          }),
          title: Flexible(child: Consumer<UserProvider>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Text(
                value.user is ParkingUser
                    ? value.user.firstName + " " + value.user.lastName
                    : value.user.name,
                style: kTextStyle.copyWith(
                  color: kPrimaryColor,
                ),
              );
            },
          )),
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
            Navigator.pushNamed(context, ProfileScreen.id);
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
          onTap: () {
            Navigator.pushNamed(context, LoginScreen.id);
          },
        ),
      ],
    ),
  );
}
