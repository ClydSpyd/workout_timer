// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:workout_timer/components/list_maker.dart';
import 'package:workout_timer/screens/home_list.dart';
import 'package:workout_timer/screens/setup.dart';
import 'package:workout_timer/screens/setup_with_lists.dart';
import 'package:workout_timer/screens/workout.dart';
import 'package:workout_timer/utilities/dummy_list.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int roundLength = 60;
  int restLength = 30;
  int sets = 10;
  int selectedIdx = 0;
  String stage = "setup";

  updateRound(int newData) {
    setState(() {
      roundLength = newData;
    });
  }

  updateRest(int newData) {
    setState(() {
      restLength = newData;
    });
  }

  updateStage(String newData) {
    setState(() {
      stage = newData;
    });
  }

  updateSets(int newData) {
    setState(() {
      sets = newData;
    });
  }

  updateSelected(int newData) {
    setState(() {
      selectedIdx = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: stage == "setup"
          ? Setup(updateStage, updateRest, updateRound, updateSets,
              updateSelected, roundLength, restLength, sets, selectedIdx)
          : Workout(
              roundLength,
              restLength,
              updateStage,
              selectedIdx,
              selectedIdx == baseList.length - 1
                  ? sets
                  : baseList.elementAt(selectedIdx)["items"].length),
    );
  }
}
