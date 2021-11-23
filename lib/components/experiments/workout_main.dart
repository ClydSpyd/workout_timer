// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:workout_timer/exercises.dart';
import 'package:workout_timer/experiments/timer.dart';

class WorkoutMain extends StatefulWidget {
  const WorkoutMain({Key? key}) : super(key: key);

  @override
  _WorkoutMainState createState() => _WorkoutMainState();
}

class _WorkoutMainState extends State<WorkoutMain> {
  int _duration = 4;
  int _roundLength = 4;
  int _restLength = 2;
  int _sets = exercises.length;
  int _roundNumber = 0;
  int _exerciseIdx = 0;
  bool _isComplete = false;
  bool _isRunning = false;

  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyTimer(
              _duration, _controller, _nextRound, _setRoundData, _roundNumber),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
            child: (_isComplete
                ? Text("FINISHED")
                : !_isRunning
                    ? Text("")
                    : Text(
                        (_roundNumber % 2 == 0)
                            ? "REST"
                            : exercises[_exerciseIdx],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      )),
          ),
          (!_isComplete
              ? Text((_roundNumber != ((_sets * 2) - 1))
                  ? "Up Next: ${_isRunning ? exercises[_exerciseIdx + 1] : exercises[_exerciseIdx]}"
                  : "")
              : Text("")),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
          ),
          _button(title: "Start", onPressed: () => {_controller.start()}),
          SizedBox(
            width: 10,
          ),
          _button(title: "Pause", onPressed: () => _controller.pause()),
          SizedBox(
            width: 10,
          ),
          _button(title: "Resume", onPressed: () => _controller.resume()),
        ],
      ),
    );
  }

  _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
        ),
      ),
    );
  }

  _nextRound() {
    if (_roundNumber != ((_sets * 2) - 1)) {
      _controller.restart(duration: _duration);
    } else {
      setState(() {
        _isComplete = true;
        _isRunning = false;
      });
    }
  }

  _setRoundData() {
    setState(
      () {
        _isRunning = true;
        _roundNumber++;
        if (_roundNumber % 2 != 0) {
          _duration = _restLength;
          if (_roundNumber > 1) {
            _exerciseIdx++;
          }
        } else {
          _duration = _roundLength;
        }
      },
    );
  }
}
