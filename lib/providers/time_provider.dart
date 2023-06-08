import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/helpers/format_date.dart';

class TimeProvider extends ChangeNotifier {
  Map<String, Map<String, String>> times = {
    'from': {
      'hour': '00',
      'minute': '00',
    },
    'to': {
      'hour': '00',
      'minute': '00',
    },
  };

  DateTime _date = DateTime.now();

  dynamic get from => times['from'];
  dynamic get to => times['to'];
  dynamic get date => _date;

  setFrom(String key, String value) {
    times['from']![key] = value;
    notifyListeners();
  }

  setTo(String key, String value) {
    times['to']![key] = value;
    notifyListeners();
  }

  setDate(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }

  setInitialValue(DateTime from, DateTime to) {
    FormatDate formatDate = FormatDate();
    setFrom('hour', formatDate.formatHour(from).toString());
    setFrom('minute', formatDate.formatMinute(from).toString());
    setTo('hour', formatDate.formatHour(to).toString());
    setTo('minute', formatDate.formatMinute(to).toString());
    notifyListeners();
  }

  List<DropdownMenuItem<String>> hoursDropdownMenu() {
    List<DropdownMenuItem<String>> result = [];

    for (String item in hours) {
      var newItem = DropdownMenuItem(
        value: item,
        child: Text(item),
      );
      result.add(newItem);
    }

    return result;
  }

  List<DropdownMenuItem<String>> minutesDropdownMenu() {
    List<DropdownMenuItem<String>> result = [];

    for (String item in minutes) {
      var newItem = DropdownMenuItem(
        value: item,
        child: Text(item),
      );
      result.add(newItem);
    }

    return result;
  }
}
