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
      vertical: 10,
      horizontal: 25,
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
  fontSize: 18.0,
);

List<String> hours = [
  '00',
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
];

List<String> minutes = [
  '00',
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31',
  '32',
  '33',
  '34',
  '35',
  '36',
  '37',
  '38',
  '39',
  '40',
  '41',
  '42',
  '43',
  '44',
  '45',
  '46',
  '47',
  '48',
  '49',
  '50',
  '51',
  '52',
  '53',
  '54',
  '55',
  '56',
  '57',
  '58',
  '59',
];
