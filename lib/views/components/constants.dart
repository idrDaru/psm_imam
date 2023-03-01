import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFE85A2A);
const kSecondaryColor = Color(0xFFD9D9D9);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your value',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);

const kSendButtonStyle = ButtonStyle(
  backgroundColor: MaterialStatePropertyAll<Color>(
    kPrimaryColor,
  ),
  padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
    EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 100,
    ),
  ),
  shadowColor: MaterialStatePropertyAll<Color>(Colors.grey),
  elevation: MaterialStatePropertyAll<double>(5.0),
);

const kTextStyle = TextStyle(
  fontFamily: 'Poppins',
  color: Colors.black,
  fontWeight: FontWeight.normal,
);

const kTitleTextStyle = TextStyle(
  fontFamily: 'Poppins',
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);
