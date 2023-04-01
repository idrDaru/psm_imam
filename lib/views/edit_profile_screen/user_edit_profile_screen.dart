import 'package:flutter/material.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/header.dart';
import 'package:psm_imam/views/components/shadow_text_field.dart';
import 'package:psm_imam/views/components/submit_button.dart';

class UserEditProfileScreen extends StatelessWidget {
  static String id = 'user_edit_profile_screen';
  const UserEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Text(
            'Back',
            style: kTextStyle,
          ),
        ),
        leadingWidth: 100.0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header(title: 'Edit Profile'),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  bottom: 50.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/194/194938.png',
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SubmitButton(title: 'Change Photo', onPressed: () {}),
                    const SizedBox(height: 50.0),
                    // const ShadowTextField(title: 'Imam Daru '),
                    // const ShadowTextField(title: 'Rismi'),
                    // const ShadowTextField(title: 'rismi@graduate.utm.my'),
                    // const ShadowTextField(title: '********'),
                    // const ShadowTextField(title: '********'),
                    const SizedBox(height: 20.0),
                    SubmitButton(title: 'Save', onPressed: () {}),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
