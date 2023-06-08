// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/models/parking_spot.dart';
import 'package:psm_imam/view_models/parking_layout_view_model.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ParkingLayoutComponent extends StatelessWidget {
  const ParkingLayoutComponent({super.key});

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
              Consumer<ParkingLayoutViewModel>(
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
                  Consumer<ParkingLayoutViewModel>(
                    builder: (context, value, child) {
                      return Column(
                        children: value.car1,
                      );
                    },
                  ),
                  Consumer<ParkingLayoutViewModel>(
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

class ParkingSpotButton extends StatefulWidget {
  ParkingSpotButton({
    super.key,
    required this.data,
    required this.isEditable,
  });

  ParkingSpot data;
  bool isEditable;

  @override
  State<ParkingSpotButton> createState() => _ParkingSpotButtonState();
}

class _ParkingSpotButtonState extends State<ParkingSpotButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.data.type == 1 ? 20 : 100,
      height: widget.data.type == 1 ? 50 : 40,
      margin: widget.data.type == 1
          ? null
          : const EdgeInsets.symmetric(vertical: 5.0),
      child: Consumer<ParkingLayoutViewModel>(
        builder: (context, value, child) {
          return ElevatedButton(
            onPressed: () async {
              widget.data.status! && value.isEditable
                  ? await value.handleSelect(widget.data)
                  : null;
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                widget.data.status ?? widget.data.status!
                    ? value.selectedPosition.contains(widget.data.id)
                        ? Colors.blue.shade300
                        : kSecondaryColor
                    : Colors.red,
              ),
            ),
            child: const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
