// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/models/parking_layout.dart';
import 'package:psm_imam/providers/parking_layout_provider.dart';

class ParkingLayoutComponent extends StatefulWidget {
  ParkingLayoutComponent({
    super.key,
    required this.data,
    required this.isEditable,
  });

  final ParkingLayout data;
  final bool isEditable;

  @override
  State<ParkingLayoutComponent> createState() => _ParkingLayoutComponentState();
}

class _ParkingLayoutComponentState extends State<ParkingLayoutComponent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ParkingLayoutProvider>(context, listen: false)
          .handleData(widget.data, widget.isEditable);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 11 / 12,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(
            width: 2.0,
            color: kSecondaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Consumer<ParkingLayoutProvider>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: value.motorcycle,
                  );
                },
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<ParkingLayoutProvider>(
                    builder: (context, value, child) {
                      return Column(
                        children: value.car1,
                      );
                    },
                  ),
                  Consumer<ParkingLayoutProvider>(
                    builder: (context, value, child) {
                      return Column(
                        children: value.car2,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParkingLayoutButton extends StatefulWidget {
  ParkingLayoutButton({
    super.key,
    required this.callback,
    required this.data,
    required this.isEditable,
  });

  Function(dynamic) callback;
  dynamic data;
  bool isEditable;

  @override
  State<ParkingLayoutButton> createState() => _ParkingLayoutButtonState();
}

class _ParkingLayoutButtonState extends State<ParkingLayoutButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.data.type == 1 ? 20 : 100,
      height: widget.data.type == 1 ? 50 : 40,
      margin: widget.data.type == 1
          ? null
          : const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        onPressed: () {
          widget.data.status && widget.isEditable
              ? setState(() {
                  isSelected = !isSelected;
                })
              : null;
          widget.data.status ? widget.callback(widget.data) : null;
        },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            widget.data.status
                ? isSelected
                    ? Colors.blue.shade300
                    : kSecondaryColor
                : Colors.red,
          ),
        ),
        child: const SizedBox.shrink(),
      ),
    );
  }
}
