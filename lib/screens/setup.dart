// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:workout_timer/components/radio_button.dart';
import 'package:workout_timer/utilities/dummy_list.dart';
import 'package:workout_timer/utilities/map_indexed.dart';

class Setup extends StatefulWidget {
  Setup(
      this.updateStage,
      this.updateRest,
      this.updateRound,
      this.updateSets,
      this.updateSelected,
      this.roundLength,
      this.restLength,
      this.sets,
      this.selectedIdx,
      {Key? key})
      : super(key: key);
  Function updateRound;
  Function updateRest;
  Function updateStage;
  Function updateSets;
  Function updateSelected;
  int roundLength = 60;
  int restLength = 30;
  int sets;
  int selectedIdx;

  @override
  _SetupState createState() => _SetupState();
}

class WorkoutObject {
  String title;
  List items;

  WorkoutObject({required this.title, required this.items});

  toJSONEncodable() {
    Map<String, dynamic> object = {};

    object['title'] = title;
    object['items'] = items;

    return object;
  }
}

class WorkoutList {
  List<WorkoutObject> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

class _SetupState extends State<Setup> {
  final WorkoutList list = WorkoutList();
  final LocalStorage storage = LocalStorage('todo_app');
  bool initialized = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> workoutRadios = baseList
        .mapIndexed((item, idx) => Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                WorkoutRadioButton(item["title"], idx, widget.selectedIdx,
                    widget.updateSelected)
              ]),
            ))
        .toList();
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[900],
      //   elevation: 0.0,
      // ),
      backgroundColor: Colors.grey[900],
      body: Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.pink)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 35.0),
                      child: Text("Workout Setup",
                          style: TextStyle(
                              color: Colors.cyan,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Round duration",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          Text(
                            '${widget.roundLength.toString()}s',
                            style:
                                TextStyle(color: Colors.orange, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      min: 0,
                      max: 120,
                      divisions: 12,
                      value: widget.roundLength.toDouble(),
                      inactiveColor: Colors.grey,
                      activeColor: Colors.cyan,
                      onChanged: (double newValue) =>
                          widget.updateRound(newValue.round()),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Divider(
                        height: 2,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rest time",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          Text(
                            '${widget.restLength.toString()}s',
                            style:
                                TextStyle(color: Colors.orange, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      min: 0,
                      max: 60,
                      divisions: 12,
                      value: widget.restLength.toDouble(),
                      inactiveColor: Colors.grey,
                      activeColor: Colors.cyan,
                      onChanged: (double newValue) =>
                          widget.updateRest(newValue.round()),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        // padding: const EdgeInsets.fromLTRB(60.0, 0, 0, 8.0),
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Routine",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 0),
                        child: ListView(
                          padding: EdgeInsets.only(top: 10.0),
                          children: [
                            ...workoutRadios,
                            if (widget.selectedIdx == baseList.length - 1)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    45.0, 5.0, 45.0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sets",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                    Text(
                                      widget.sets.toString(),
                                      style: TextStyle(
                                          color: Colors.orange, fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                            if (widget.selectedIdx == baseList.length - 1)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Slider(
                                  min: 0,
                                  max: 20,
                                  divisions: 20,
                                  value: widget.sets.toDouble(),
                                  inactiveColor: Colors.grey,
                                  activeColor: Colors.cyan,
                                  onChanged: (double newValue) =>
                                      widget.updateSets(newValue.round()),
                                ),
                              ),
                          ],
                          // itemExtent: 60.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 5.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 180, height: 60),
                  child: ElevatedButton(
                    child: Text("Confirm",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade900)),
                    onPressed: () => widget.updateStage("workout"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
