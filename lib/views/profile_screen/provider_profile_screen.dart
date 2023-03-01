import 'package:flutter/material.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/sidebar.dart';
import 'package:psm_imam/views/profile_screen/components/profile_header.dart';
import 'package:psm_imam/views/profile_screen/components/profile_scrolled_row.dart';

class ProviderProfileScreen extends StatelessWidget {
  static String id = 'provider_profile_screen';
  const ProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      drawer: Sidebar(),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        physics: const BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              const ProfileHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'PROVIDER',
                        style: kTitleTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 30.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/194/194938.png',
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Flexible(
                            child: Text(
                              'Universiti Teknologi Malaysia',
                              style: kTitleTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '2',
                              style: kTitleTextStyle.copyWith(
                                color: const Color(0xFFE85A2A),
                              ),
                            ),
                            const Text(
                              'Parking Spaces',
                              style: kTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '6',
                              style: kTitleTextStyle.copyWith(
                                color: const Color(0xFFE85A2A),
                              ),
                            ),
                            const Text(
                              'Deactivated',
                              style: kTextStyle,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: kSendButtonStyle.copyWith(
                            padding: const MaterialStatePropertyAll<
                                EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 50.0,
                              ),
                            ),
                          ),
                          child: const Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height / 2.5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ProfileScrolledRow(title: 'TITLE'),
                      ProfileScrolledRow(title: 'TITLE'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
