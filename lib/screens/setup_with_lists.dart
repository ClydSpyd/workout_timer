// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:workout_timer/components/list_maker.dart';

class SetupWithLists extends StatefulWidget {
  const SetupWithLists({Key? key}) : super(key: key);

  @override
  _SetupWithListsState createState() => _SetupWithListsState();
}

//list object to be saved/retrieved from LS
class WorkoutList {
  String title;
  List items;

  WorkoutList({required this.title, required this.items});

  toJSONEncodable() {
    var m = {"title": title, "items": items};

    return m;
  }
}

//list of lists retrived from LS to display on main setup page
class SavedWorkouts {
  List<WorkoutList> items = [];

  add(WorkoutList newItem) {
    items.add(newItem);
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

class _SetupWithListsState extends State<SetupWithLists> {
  final SavedWorkouts list = SavedWorkouts();
  final LocalStorage storage = LocalStorage('workout_app');
  bool initialized = false;
  bool showCreator = false;

  _saveToStorage(WorkoutList newItem) {
    list.add(newItem);
    storage.setItem('workouts', list.toJSONEncodable());
  }

  addNewWorkout(WorkoutList newItem) {
    _saveToStorage(newItem);
    setState(() {
      showCreator = false;
    });
    print(newItem.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("with list"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        constraints: BoxConstraints.expand(),
        child: showCreator
            ? ListMaker(addNewWorkout)
            : FutureBuilder(
                future: storage.ready,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!initialized) {
                    var items = storage.getItem('workouts');

                    if (items != null) {
                      print(items[0].values.last);
                      print(items);
                      list.items = List<WorkoutList>.from(
                        (items as List).map(
                          (item) => WorkoutList(
                              title: item.values.first,
                              items: item.values.elementAt(1)),
                        ),
                      );
                      print(list.items[0].title);
                      print("list.items");
                    }

                    initialized = true;
                  }

                  List<Widget> widgets = list.items.map((item) {
                    return ListTile(title: Text(item.title));
                  }).toList();

                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListView(
                          children: widgets,
                          itemExtent: 50.0,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.cyan)),
                              onPressed: () => setState(
                                () {
                                  showCreator = true;
                                },
                              ),
                              child: Text(
                                "new list",
                                style: TextStyle(
                                  color: Colors.cyan,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}
