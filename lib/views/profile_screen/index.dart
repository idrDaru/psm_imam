import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/models/parking_provider.dart';
import 'package:psm_imam/models/parking_user.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/services/networking.dart';
import 'package:psm_imam/view_models/user.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/custom_scaffold.dart';
import 'package:psm_imam/views/components/sidebar.dart';
import 'package:psm_imam/views/edit_profile_screen/index.dart';

class ProfileScreen extends StatefulWidget {
  static String id = 'profile_screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, List> profileData = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getUserData();
    });
  }

  getProfileData() async {
    const storage = FlutterSecureStorage();
    String? key = await storage.read(key: 'access_token');
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $key',
    };

    NetworkHelper networkHelper = NetworkHelper(endpoint: '', header: header);
  }

  List<Widget> parkingProviderScrolledRow() {
    return [
      ProfileScrolledRow(title: 'My Parking Space'),
      ProfileScrolledRow(title: 'Deactivate Parking Spaces'),
    ];
  }

  List<Widget> parkingUserScrolledRow() {
    return [
      ProfileScrolledRow(title: 'My Upcoming Parking'),
      ProfileScrolledRow(title: 'My Voucher'),
      ProfileScrolledRow(title: 'My Parking History'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Consumer<UserProvider>(builder: (context, value, child) {
          return const Sidebar();
        }),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kPrimaryColor),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 0),
          physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                const ProfileHeader(),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 50,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Center(child: Consumer<UserProvider>(
                        builder: (context, value, child) {
                          if (value.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text(
                            value.user is ParkingUser ? "PROFILE" : "PROVIDER",
                            style: kTitleTextStyle,
                          );
                        },
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 30.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<UserProvider>(
                                builder: (context, value, child) {
                              if (value.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                  value.user.user.imageDownloadURL,
                                ),
                              );
                            }),
                            const SizedBox(width: 20.0),
                            Flexible(
                              child: Consumer<UserProvider>(
                                  builder: (context, value, child) {
                                if (value.isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Text(
                                  value.user is ParkingUser
                                      ? '${value.user.firstName} ${value.user.lastName}'
                                      : '${value.user.name}',
                                  style: kTitleTextStyle,
                                );
                              }),
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
                              Consumer<UserProvider>(
                                  builder: (context, value, child) {
                                if (value.isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Text(
                                  value.user is ParkingUser
                                      ? 'Waiting for Payment'
                                      : 'Parking Spaces',
                                  style: kTextStyle.copyWith(fontSize: 12.0),
                                );
                              }),
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
                              Consumer<UserProvider>(
                                  builder: (context, value, child) {
                                if (value.isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Text(
                                  value.user is ParkingUser
                                      ? 'Upcoming Parking'
                                      : 'Deactivated',
                                  style: kTextStyle.copyWith(fontSize: 12.0),
                                );
                              })
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                EditProfileScreen.id,
                                arguments: Provider.of<UserProvider>(
                                  context,
                                  listen: false,
                                ).user,
                              );
                            },
                            style: kSendButtonStyle.copyWith(
                              padding: const MaterialStatePropertyAll<
                                  EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 25.0,
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
                  margin: EdgeInsets.only(top: height / 2.3),
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
                      children:
                          Provider.of<UserProvider>(context).user is ParkingUser
                              ? parkingUserScrolledRow()
                              : parkingProviderScrolledRow(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 2,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Background.png'),
          fit: BoxFit.cover,
        ),
        color: kSecondaryColor,
      ),
    );
  }
}

class ProfileScrolledRow extends StatelessWidget {
  const ProfileScrolledRow({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Text(
          title,
          style: kTitleTextStyle,
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 100.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
