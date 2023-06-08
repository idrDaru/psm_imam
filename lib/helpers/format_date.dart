// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

class FormatDate {
  DateTime parseDateTime(DateTime date, String hour, String minute) {
    DateTime result = DateTime.now();

    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final String dateOnly = dateFormat.format(date);
    final String dateTimeString = "$dateOnly $hour:$minute:00";
    result = DateTime.parse(dateTimeString);

    return result;
  }

  String formatHour(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat("HH");
    final String result = dateFormat.format(dateTime);

    return result;
  }

  String formatMinute(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat("mm");
    final String result = dateFormat.format(dateTime);

    return result;
  }
}
