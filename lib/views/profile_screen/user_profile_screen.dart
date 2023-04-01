import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:psm_imam/services/networking.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/sidebar.dart';
import 'package:psm_imam/views/edit_profile_screen/user_edit_profile_screen.dart';
import 'package:psm_imam/views/profile_screen/components/profile_header.dart';
import 'package:psm_imam/views/profile_screen/components/profile_scrolled_row.dart';

class UserProfileScreen extends StatefulWidget {
  static String id = 'user_profile_screen';
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String firstName = '', lastName = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    await dotenv.load(fileName: ".env");

    Map<String, String> body = {};

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + dotenv.env['ACCESS_TOKEN'].toString(),
    };

    NetworkHelper networkHelper = NetworkHelper(endpoint: '/api/user/', header: header);

    var response = await networkHelper.getData();
    var decodeResponse = jsonDecode(response.body);
    
    if (decodeResponse['status'] == 200) {
      setState(() {
        firstName = decodeResponse['data']['first_name'];
        lastName = decodeResponse['data']['last_name'];
      });
    } else {
      print(decodeResponse['message']);
    }
  }

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
                        'PROFILE',
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
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/194/194938.png',
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Flexible(
                            child: Text(
                              '$firstName $lastName',
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
                                color: kPrimaryColor,
                              ),
                            ),
                            const Text(
                              'Waiting for Payment',
                              style: kTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '6',
                              style: kTitleTextStyle.copyWith(
                                color: kPrimaryColor,
                              ),
                            ),
                            const Text(
                              'Upcoming Payment',
                              style: kTextStyle,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, UserEditProfileScreen.id);
                          },
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
