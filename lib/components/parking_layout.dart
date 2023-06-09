// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/models/parking_spot.dart';
import 'package:psm_imam/view_models/parking_layout_view_model.dart';

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
              // LayoutBuilder(
              //   builder: (p0, p1) {
              //     return SizedBox(
              //       height: 50,
              //       width: p1.maxWidth,
              //       child: ListView.separated(
              //         shrinkWrap: true,
              //         scrollDirection: Axis.horizontal,
              //         itemBuilder: (context, index) {
              //           return LayoutId(
              //             id: index + 1,
              //             // child: Container(),
              //             child: Provider.of<ParkingLayoutViewModel>(context)
              //                 .motorcycleSpotButton[index][index]!,
              //           );
              //         },
              //         separatorBuilder: (context, index) =>
              //             const SizedBox(width: 5.5),
              //         itemCount: 13,
              //       ),
              //     );
              //   },
              // ),
              // const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         LayoutId(
              //           id: 1,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 2,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 3,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 4,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 5,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 6,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 7,
              //           child: CarSpotButton(),
              //         ),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         LayoutId(
              //           id: 8,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 9,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 10,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 11,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 12,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 13,
              //           child: CarSpotButton(),
              //         ),
              //         LayoutId(
              //           id: 14,
              //           child: CarSpotButton(),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
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

class MotorcycleSpotButton extends StatelessWidget {
  MotorcycleSpotButton({
    super.key,
    required this.position,
  });

  String position;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            kSecondaryColor,
          ),
        ),
        // child: const SizedBox.shrink(),
        child: Text(
          position,
          style: kTextStyle,
        ),
      ),
    );
  }
}

class CarSpotButton extends StatelessWidget {
  const CarSpotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: () {},
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            kSecondaryColor,
          ),
        ),
        child: const SizedBox.shrink(),
      ),
    );
  }
}
