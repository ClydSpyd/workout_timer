// ignore_for_file: prefer_final_fields, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:timer_controller/timer_controller.dart';
import 'package:workout_timer/components/control_buttons.dart';
import 'package:workout_timer/components/go_button.dart';
import 'package:workout_timer/components/restart_button.dart';
import 'package:workout_timer/components/workout_text.dart';
import 'package:workout_timer/exercises.dart';
import 'package:workout_timer/components/countdown_timer.dart';
import 'dart:async';

import 'package:workout_timer/utilities/dummy_list.dart';

class Workout extends StatefulWidget {
  Workout(this.roundLength, this.restLength, this.updateStage, this.selectedIdx,
      this.sets,
      {Key? key})
      : super(key: key);
  int roundLength;
  int restLength;
  int selectedIdx;
  int sets;
  Function updateStage;

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  late TimerController _controller;
  int duration = 5;
  int _roundNumber = 0;
  int _exerciseIdx = 0;
  bool _isRunning = false;
  bool _cycleFinished = false;

  @override
  Widget build(BuildContext context) {
    _controller = TimerController.seconds(duration);
    List exercises = dummyList.elementAt(widget.selectedIdx)["items"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
                (!_isRunning && !_cycleFinished) || _cycleFinished
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 48.0),
                  child: Column(
                    mainAxisAlignment:
                        (!_isRunning && !_cycleFinished) || _cycleFinished
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: (!_isRunning && !_cycleFinished)
                        ? [GoButton(_handleStart, widget.updateStage)]
                        : _cycleFinished
                            ? [RestartButton(_handleStart, _handleReset)]
                            : [
                                CountdownTimer(_controller, _handleFinish),
                                WorkoutText(_roundNumber, _exerciseIdx,
                                    widget.sets, widget.selectedIdx, exercises),
                                ControlButons(_controller, _isRunning,
                                    _roundNumber, _handleReset, _handleSkip)
                              ],
                  ),
                ),
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
      Timer(Duration(milliseconds: 50), () => _controller.start());
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
    if (_roundNumber != ((widget.sets * 2) - 1)) {
      setState(() {
        _roundNumber++;
        duration =
            _roundNumber % 2 == 0 ? widget.restLength : widget.roundLength;
        if (_roundNumber > 0 && _roundNumber % 2 == 0) {
          _exerciseIdx++;
        }
      });
      Timer(Duration(milliseconds: 50), () => _controller.start());
    } else {
      setState(
        () {
          _isRunning = false;
          _cycleFinished = true;
        },
      );
    }
  }

  _handleSkip(bool forward) {
    setState(() {
      if (forward) {
        _handleFinish();
      } else {
        if (_roundNumber == 0) {
          return;
        } else if (_roundNumber != ((widget.sets * 2) - 1)) {
          setState(() {
            _roundNumber--;
            duration = _roundNumber == 0
                ? 5
                : _roundNumber % 2 == 0
                    ? widget.restLength
                    : widget.roundLength;
            if (_roundNumber > 0 && _roundNumber % 2 != 0) {
              _exerciseIdx--;
            }
          });
          Timer(Duration(milliseconds: 50), () => _controller.start());
        } else {
          setState(
            () {
              _isRunning = false;
              _cycleFinished = true;
            },
          );
        }
      }
    });
    Timer(Duration(milliseconds: 50), () => _controller.start());
  }
}


  // _handleFinish() {
  //   // debugPrint((_roundNumber % 2 != 0).toString());
  //   // debugPrint(_sets.toString());

  //   if (_roundNumber != ((_sets * 2))) {
  //     _isRunning = true;
  //     _roundNumber++;

  //     if (_roundNumber % 2 != 0) {
  //       duration = widget.restLength;
  //       if (_roundNumber > 1) {
  //         _exerciseIdx++;
  //       }
  //     } else {
  //       duration = widget.roundLength;
  //     }

  //     debugPrint("HELLO");
  //     duration = roundLength;
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