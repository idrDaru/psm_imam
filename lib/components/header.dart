import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 3,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: const Color(0xFFE85A2A),
          ),
        ),
      ),
    );
  }
}
