import 'package:flutter/material.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/sidebar.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold({super.key, required this.body});
  Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Sidebar(),
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
