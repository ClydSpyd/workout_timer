// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class MyTimer extends StatefulWidget {
  MyTimer(this.duration, this.controller, this.nextRound, this.setRoundData,
      this.roundNumber,
      {Key? key})
      : super(key: key);

  int duration;
  int roundNumber;
  CountDownController controller;
  Function nextRound;
  Function setRoundData;

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularCountDownTimer(
        duration: widget.duration,
        initialDuration: 0,
        controller: widget.controller,
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 1.5,
        ringColor: Colors.grey[300]!,
        ringGradient: null,
        fillColor: (widget.roundNumber % 2 == 0)
            ? Colors.cyan[300]!
            : Colors.purpleAccent[100]!,
        fillGradient: null,
        backgroundColor: Colors.white,
        backgroundGradient: null,
        strokeWidth: 15.0,
        strokeCap: StrokeCap.butt,
        textStyle: TextStyle(
            fontSize: 33.0, color: Colors.purple, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.SS,
        isReverse: false,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: false,
        onComplete: () => widget.nextRound(),
        onStart: () => widget.setRoundData(),
      ),
    );
  }
}
