// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:timer_controller/timer_controller.dart';

class ControlButons extends StatefulWidget {
  ControlButons(this.controller, this.isRunning, this.roundNumber,
      this.handleReset, this.handleSkip,
      {Key? key})
      : super(key: key);
  TimerController controller;
  bool isRunning;
  int roundNumber;
  Function handleReset;
  Function handleSkip;

  @override
  State<ControlButons> createState() => _ControlButonsState();
}

class _ControlButonsState extends State<ControlButons> {
  bool _isPaused = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 230,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 15),
              child: ClipOval(
                child: Material(
                  color:
                      !_isPaused ? Colors.cyan : Colors.orange, // Button color
                  child: InkWell(
                    splashColor: Colors.cyanAccent, // Splash color
                    onTap: () => {_handlePause(!_isPaused)},
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Center(
                        child: Icon(!_isPaused ? Icons.pause : Icons.play_arrow,
                            size: 40),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _IconButton(
                  icon: Icons.skip_previous,
                  onPressed: () => {
                    widget.handleSkip(false),
                    setState(
                      () {
                        _isPaused = false;
                      },
                    ),
                  },
                ),
                _ActionButton(
                  title: 'Reset workout',
                  onPressed: () => widget.handleReset(),
                ),
                _IconButton(
                  icon: Icons.skip_next,
                  onPressed: () => widget.handleSkip(true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _handlePause(bool input) {
    setState(() {
      _isPaused = input;
    });
    if (!_isPaused) {
      widget.controller.start();
    } else {
      widget.controller.pause();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.cyan)),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.cyan,
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.cyan)),
        onPressed: onPressed,
        child: Icon(
          icon,
          color: Colors.cyan,
        ),
      ),
    );
  }
}




          // _ActionButton(
          //   title: _isPaused ? 'Go' : "Pause",
          //   onPressed: () => {_handlePause(!_isPaused)},
          // ),

          // _ActionButton(
          //   title: 'Pause',
          //   onPressed: () => _controller.pause(),
          // ),,