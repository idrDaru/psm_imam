import 'package:flutter/material.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/header.dart';
import 'package:psm_imam/views/edit_parking_space_screen/index.dart';

class ManageParkingSpaceScreen extends StatelessWidget {
  static String id = 'manage_parking_space _screen';
  const ManageParkingSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Header(title: 'My Parking Spaces'),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    height: 210.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(
                        width: 2.0,
                        color: kSecondaryColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2.0,
                                          color: kSecondaryColor,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: NetworkImage(
                                          'https://cdn-icons-png.flaticon.com/512/194/194938.png',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fakulti Alam Bina dan Ukur',
                                      style: kTitleTextStyle.copyWith(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      'Fakulti Alam Bina dan Ukur, Lingkaran Ilmu, Universiti Teknologi Malaysia, 81310 Johor Bahru, Johor, Malaysia',
                                      style: kTextStyle.copyWith(
                                        fontSize: 12.0,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                    kSecondaryColor,
                                  ),
                                ),
                                child: Text(
                                  'Deactivate',
                                  style: kTextStyle.copyWith(fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, EditParkingSpaceScreen.id);
                                },
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                    kPrimaryColor,
                                  ),
                                ),
                                child: Text(
                                  'Edit Parking Space',
                                  style: kTextStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
