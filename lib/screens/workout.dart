// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:timer_controller/timer_controller.dart';
import 'package:workout_timer/components/go_button.dart';
import 'package:workout_timer/components/restart_button.dart';
import 'package:workout_timer/components/workout_text.dart';
import 'package:workout_timer/exercises.dart';
import 'package:workout_timer/components/countdown_timer.dart';
import 'dart:async';

class Workout extends StatefulWidget {
  Workout({Key? key}) : super(key: key);

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  late TimerController _controller;
  int duration = 5;
  int _roundLength = 60;
  int _restLength = 30;
  int _sets = exercises.length;
  int _roundNumber = 0;
  int _exerciseIdx = 0;
  bool _isRunning = false;
  bool _cycleFinished = false;

  @override
  Widget build(BuildContext context) {
    _controller = TimerController.seconds(duration);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 150.0, 20.0, 50.0),
        child: SizedBox.expand(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
                (!_isRunning && !_cycleFinished) || _cycleFinished
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: (!_isRunning && !_cycleFinished)
                    ? [GoButton(_handleStart)]
                    : _cycleFinished
                        ? [RestartButton(_handleStart, _handleReset)]
                        : [
                            CountdownTimer(_controller, _handleFinish),
                            WorkoutText(
                                _roundNumber, _exerciseIdx, _sets, exercises),
                          ],
              ),
              if (_isRunning)
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _ActionButton(
                      title: 'Start',
                      onPressed: () => _handleStart(),
                    ),
                    _ActionButton(
                      title: 'Pause',
                      onPressed: () => _controller.pause(),
                    ),
                    _ActionButton(
                      title: 'Reset',
                      onPressed: () => _handleReset(),
                    ),
                    _ActionButton(
                      title: 'Restart',
                      onPressed: () => _controller.restart(),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  _handleStart() {
    {
      setState(
        () {
          _isRunning = true;
          _cycleFinished = false;
        },
      );
      Timer(Duration(milliseconds: 10), () => _controller.start());
    }
  }

  _handleReset() {
    setState(() {
      duration = 5;
      _roundNumber = 0;
      _exerciseIdx = 0;
      _isRunning = false;
      _cycleFinished = false;
    });
    _controller.reset();
  }

  _handleFinish() {
    if (_roundNumber != ((_sets * 2) - 1)) {
      setState(() {
        _roundNumber++;
        duration = _roundNumber % 2 == 0 ? _restLength : _roundLength;
        if (_roundNumber > 0 && _roundNumber % 2 == 0) {
          _exerciseIdx++;
        }
      });
      Timer(Duration(milliseconds: 10), () => _controller.start());
    } else {
      setState(
        () {
          _isRunning = false;
          _cycleFinished = true;
        },
      );
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(color: Colors.cyan),
      ),
    );
  }
}



  // _handleFinish() {
  //   // debugPrint((_roundNumber % 2 != 0).toString());
  //   // debugPrint(_sets.toString());

  //   if (_roundNumber != ((_sets * 2))) {
  //     _isRunning = true;
  //     _roundNumber++;

  //     if (_roundNumber % 2 != 0) {
  //       duration = _restLength;
  //       if (_roundNumber > 1) {
  //         _exerciseIdx++;
  //       }
  //     } else {
  //       duration = _roundLength;
  //     }

  //     debugPrint("HELLO");
  //     duration = _roundLength;
  //     Timer(Duration(milliseconds: 150), () => _controller.start());
  //   } else {
  //     setState(() {
  //       debugPrint("FAIL");
  //       _isComplete = true;
  //       _isRunning = false;
  //     });
  //   }
  //   // setState(() {
  //   //   duration = 60;

  //   // });
  // }


  // cycleFinished:
  // _roundNumber == _sets * 2 - 1 && !_isRunning ? 