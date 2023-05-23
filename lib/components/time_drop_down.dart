import 'package:flutter/material.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/submit_button.dart';

class TimeDropdown extends StatefulWidget {
  TimeDropdown({
    super.key,
    required this.type,
    required this.time,
    required this.callback,
  });

  final String? type;
  final Map<String, String>? time;
  void Function(String?, String?, String?)? callback;

  @override
  State<TimeDropdown> createState() => _TimeDropdownState();
}

class _TimeDropdownState extends State<TimeDropdown> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.type == 'from'
                  ? 'At what time will your parking start?'
                  : 'At what time will your parking end?',
              style: kTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Hours',
                  style: kTitleTextStyle.copyWith(
                    color: kPrimaryColor,
                  ),
                ),
                DropdownButton(
                  value: widget.time!['hour'],
                  items: hoursDropdownMenu(),
                  onChanged: (value) {
                    widget.callback!(value, widget.type, 'hour');
                  },
                ),
                DropdownButton(
                  value: widget.time!['minute'],
                  items: minutesDropdownMenu(),
                  onChanged: (value) {
                    widget.callback!(value, widget.type, 'minute');
                  },
                ),
                Text(
                  'Minutes',
                  style: kTitleTextStyle.copyWith(
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            SubmitButton(
              title: 'Confirm',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
