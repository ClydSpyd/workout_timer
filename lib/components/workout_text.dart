// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WorkoutText extends StatelessWidget {
  WorkoutText(this.roundNumber, this.exerciseIdx, this.sets, this.exercises,
      {Key? key})
      : super(key: key);

  int roundNumber;
  int exerciseIdx;
  int sets;
  List exercises;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Container(
        height: 300,
        width: 600,
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Text(
                roundNumber == 0
                    ? "Get Ready..."
                    : roundNumber % 2 == 0
                        ? "REST"
                        : exercises[exerciseIdx],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0),
              child: Text(
                (roundNumber != ((sets * 2) - 1))
                    ? "Up next: ${exercises[roundNumber == 0 ? 0 : roundNumber % 2 == 0 ? exerciseIdx : exerciseIdx == exercises.length - 1 ? exerciseIdx : exerciseIdx + 1]}"
                    : "",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orange[700], fontSize: 16),
                // style: TextStyle(color: Colors.blueGrey[300], fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
