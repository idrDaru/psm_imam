import 'package:flutter/material.dart';
import 'constants.dart';

typedef StringValue = String Function(String);

// ignore: must_be_immutable
class ShadowTextField extends StatefulWidget {
  ShadowTextField(
    this.callback, {
    super.key,
    required this.title,
  });

  final String title;
  late Function callback;

  @override
  State<ShadowTextField> createState() => _ShadowTextFieldState();
}

class _ShadowTextFieldState extends State<ShadowTextField> {
  TextEditingController textController = TextEditingController();

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
            controller: textController,
            onChanged: (value) {
              widget.callback(value);
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: widget.title,
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
