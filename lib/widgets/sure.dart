// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_null_comparison, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';

class SureWidget extends StatefulWidget {
  SureWidget({Key? key, required this.sureDeger}) : super(key: key);
  final Function(int value) sureDeger;

  @override
  State<SureWidget> createState() => _SureWidgetState();
}

class _SureWidgetState extends State<SureWidget> {
  int sure = 0;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      widget.sureDeger(timer.tick);
      sure = timer.tick;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange.shade100,
        ),
        child: Text(
          "Süre: ${_printDuration(Duration(seconds: sure))}",
          style: TextStyle(fontSize: 20),
        ));
  }
}
