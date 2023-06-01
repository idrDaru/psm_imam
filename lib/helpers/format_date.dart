import 'package:intl/intl.dart';

class FormatDate {
  DateTime formatDateTime(DateTime date, String hour, String minute) {
    DateTime result = DateTime.now();

    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final String dateOnly = dateFormat.format(date);
    final String dateTimeString = "$dateOnly $hour:$minute:00";
    result = DateTime.parse(dateTimeString);

    return result;
  }
}
