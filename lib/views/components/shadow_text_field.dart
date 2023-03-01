import 'package:flutter/material.dart';
import 'constants.dart';

class ShadowTextField extends StatelessWidget {
  const ShadowTextField({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: TextField(
            onChanged: (value) {},
            decoration: kTextFieldDecoration.copyWith(
              hintText: title,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
