import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: kSendButtonStyle,
      child: Text(title),
    );
  }
}
