// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:workout_timer/utilities/dummy_list.dart';

class WorkoutText extends StatelessWidget {
  WorkoutText(this.roundNumber, this.exerciseIdx, this.sets, this.selectedIdx,
      this.exercises,
      {Key? key})
      : super(key: key);

  int roundNumber;
  int exerciseIdx;
  int sets;
  int selectedIdx;
  List exercises;

  @override
  Widget build(BuildContext context) {
    // List exercises = baseList.elementAt(selectedIdx)["items"];
    bool noList = exercises.length == 0;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      height: 220,
      width: 600,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: Text(
                roundNumber == 0
                    ? "Get Ready..."
                    : roundNumber % 2 == 0
                        ? "REST"
                        : noList
                            ? "Round ${exerciseIdx + 1}/$sets"
                            : exercises[exerciseIdx],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            if (!noList)
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0),
                child: Text(
                  (roundNumber != ((sets * 2) - 1))
                      ? "Up next: ${exercises[roundNumber == 0 ? 0 : roundNumber % 2 == 0 ? exerciseIdx : exerciseIdx == exercises.length - 1 ? exerciseIdx : exerciseIdx + 1]}"
                      : "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange[700], fontSize: 13),
                  // style: TextStyle(color: Colors.blueGrey[300], fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
