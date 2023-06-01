import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/submit_button.dart';
import 'package:psm_imam/providers/time_provider.dart';

class TimeDropdown extends StatelessWidget {
  const TimeDropdown({super.key, required this.type});

  final String type;
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
              type == 'from'
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
                Consumer<TimeProvider>(
                  builder: (context, value, child) {
                    return DropdownButton(
                      value: type == 'from'
                          ? value.from['hour']
                          : value.to['hour'],
                      items: value.hoursDropdownMenu(),
                      onChanged: (newValue) {
                        type == 'from'
                            ? Provider.of<TimeProvider>(context, listen: false)
                                .setFrom(
                                'hour',
                                newValue.toString(),
                              )
                            : Provider.of<TimeProvider>(context, listen: false)
                                .setTo(
                                'hour',
                                newValue.toString(),
                              );
                      },
                    );
                  },
                ),
                Consumer<TimeProvider>(
                  builder: (context, value, child) {
                    return DropdownButton(
                      value: type == 'from'
                          ? value.from['minute']
                          : value.to['minute'],
                      items: value.hoursDropdownMenu(),
                      onChanged: (newValue) {
                        type == 'from'
                            ? Provider.of<TimeProvider>(context, listen: false)
                                .setFrom(
                                'minute',
                                newValue.toString(),
                              )
                            : Provider.of<TimeProvider>(context, listen: false)
                                .setTo(
                                'minute',
                                newValue.toString(),
                              );
                      },
                    );
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
