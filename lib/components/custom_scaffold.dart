import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/sidebar.dart';

// ignore: must_be_immutable
class CustomScaffold extends StatelessWidget {
  CustomScaffold({super.key, required this.body});
  Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Sidebar(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kPrimaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: body,
    );
  }
}
