import 'package:flutter/material.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:timer_controller/timer_controller.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer(this._controller, this.handleFinish, {Key? key})
      : super(key: key);
  final TimerController _controller;
  final handleFinish;

  @override
  Widget build(BuildContext context) {
    return TimerControllerListener(
      controller: _controller,
      listenWhen: (previousValue, currentValue) =>
          previousValue.status != currentValue.status,
      listener: (context, timerValue) {
        // ScaffoldMessenger.of(context).showSnackBar(
        debugPrint('Status: ${timerValue.status}');
        if (timerValue.status == TimerStatus.finished) {
          handleFinish();
        }
        // );
      },
      child: TimerControllerBuilder(
        controller: _controller,
        builder: (context, timerValue, _) {
          Color? timerColor;
          switch (timerValue.status) {
            case TimerStatus.running:
              timerColor = Colors.cyan;
              break;
            case TimerStatus.paused:
              timerColor = Colors.grey;
              break;
            case TimerStatus.finished:
              timerColor = Colors.red;
              break;
            default:
          }

          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 40,
            runSpacing: 40,
            children: <Widget>[
              // CircularCountdown(
              //   diameter: 250,
              //   gapFactor: 2,
              //   strokeWidth: 125,
              //   countdownTotal: _controller.initialValue.remaining,
              //   countdownRemaining: timerValue.remaining,
              //   countdownCurrentColor: timerColor,
              // ),
              CircularCountdown(
                diameter: 250,
                gapFactor: 0.51,
                countdownTotal: _controller.initialValue.remaining,
                countdownRemaining: timerValue.remaining,
                countdownCurrentColor: Colors.orange.shade700,
                strokeWidth: 15,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 90,
                ),
              ),
              // CircularCountdown(
              //   diameter: 250,
              //   countdownTotal: _controller.initialValue.remaining,
              //   countdownRemaining: timerValue.remaining,
              //   countdownCurrentColor: timerColor,
              //   countdownRemainingColor: const Color(0xFF4F6367),
              //   countdownTotalColor: Colors.transparent,
              //   textStyle: const TextStyle(
              //     color: Color(0xFFFE5F55),
              //     fontSize: 90,
              //   ),
              // ),
              // CircularCountdown(
              //   diameter: 250,
              //   countdownTotal: _controller.initialValue.remaining,
              //   countdownRemaining: timerValue.remaining,
              //   countdownCurrentColor: timerColor,
              // ),
            ],
          );
        },
      ),
    );
  }
}
