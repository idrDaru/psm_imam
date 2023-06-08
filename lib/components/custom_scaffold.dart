import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/sidebar.dart';

// ignore: must_be_immutable
class CustomScaffold1 extends StatelessWidget {
  CustomScaffold1({super.key, required this.body});
  Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: kPrimaryColor,
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const Sidebar(),
        extendBodyBehindAppBar: true,
        body: body,
      ),
    );
  }
}
