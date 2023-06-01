import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/providers/parking_layout_provider.dart';

class ParkingLayout extends StatefulWidget {
  ParkingLayout({super.key, required this.data});

  final dynamic data;

  @override
  State<ParkingLayout> createState() => _ParkingLayoutState();
}

class _ParkingLayoutState extends State<ParkingLayout> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ParkingLayoutProvider>(context, listen: false)
          .handleData(widget.data);
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
    required this.type,
    required this.isAvailable,
    required this.id,
    required this.callback,
  });

  int type;
  bool isAvailable;
  String id;
  Function(String) callback;

  @override
  State<ParkingLayoutButton> createState() => _ParkingLayoutButtonState();
}

class _ParkingLayoutButtonState extends State<ParkingLayoutButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.type == 1 ? 20 : 100,
      height: widget.type == 1 ? 50 : 40,
      margin:
          widget.type == 1 ? null : const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        onPressed: () {
          widget.isAvailable
              ? setState(() {
                  isSelected = !isSelected;
                })
              : null;
          widget.isAvailable ? widget.callback(widget.id) : null;
        },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            widget.isAvailable
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
