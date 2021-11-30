// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:workout_timer/models/saved_workouts.dart';
import 'package:workout_timer/models/workout_list.dart';
import 'package:workout_timer/utilities/storage.dart';

class RoutineList extends StatefulWidget {
  const RoutineList({Key? key}) : super(key: key);

  @override
  _RoutineListState createState() => _RoutineListState();
}

class _RoutineListState extends State<RoutineList> {
  LS ls = LS();
  bool initialized = false;
  @override
  Widget build(BuildContext context) {
    // SavedWorkouts list = ls.list;

    return FutureBuilder(
      future: ls.storage.ready,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!initialized) {
          var items = ls.storage.getItem('workouts');

          if (items != null) {
            // print(items[0].values.last);
            // print(items);
            ls.list.items = List<WorkoutList>.from(
              (items as List).map(
                (item) => WorkoutList(
                    title: item.values.first, items: item.values.elementAt(1)),
              ),
            );
            print(ls.list.items[0].title);
            print("list.items");
          }

          initialized = true;
        }

        List<Widget> widgets = ls.list.items.map((item) {
          return ListTile(title: Text(item.title));
        }).toList();

        return Expanded(
          flex: 1,
          child: ListView(
            children: widgets,
            itemExtent: 50.0,
          ),
        );
      },
    );
  }
}
