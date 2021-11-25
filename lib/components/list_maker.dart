// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:workout_timer/screens/setup_with_lists.dart';

class ListMaker extends StatefulWidget {
  ListMaker(this.addNewWorkout, {Key? key}) : super(key: key);
  Function addNewWorkout;
  @override
  _ListMakerState createState() => _ListMakerState();
}

class NewWorkoutItems {
  List<String> items = [];

  toJSONEncodable() {
    return items.map((item) {
      return item;
    }).toList();
  }
}

class _ListMakerState extends State<ListMaker> {
  final List list = [];
  TextEditingController controller = TextEditingController();

  _addItem(String item) {
    setState(() {
      list.add(item);
    });
  }

  _save() {
    WorkoutList newList = WorkoutList(title: "NEW", items: list);
    widget.addNewWorkout(newList);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = list.map((item) {
      return ListTile(
        leading: Icon(Icons.blur_circular),
        // leading: Icon(Icons.api_outlined),
        title: Text(item),
      );
    }).toList();

    return Container(
      padding: EdgeInsets.all(10.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ListView(
              children: widgets,
              itemExtent: 50.0,
            ),
          ),
          ListTile(
            title: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'What to do?',
              ),
              onEditingComplete: _confirmItem,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () => _save(),
                  tooltip: 'Save',
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _clear(),
                  tooltip: 'Clear storage',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmItem() {
    _addItem(controller.value.text);
    controller.clear();
  }

  void _clear() {
    print("clear");
    // setState(() {
    //   list = [];
    // });
  }
}
