// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class RestartButton extends StatelessWidget {
  RestartButton(this.handleStart, this.handleReset, {Key? key})
      : super(key: key);
  Function handleStart;
  Function handleReset;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Workout Finished!",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.normal,
              color: Colors.orange.shade700),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 158.0),
          child: ClipOval(
            child: Material(
              color: Colors.cyan, // Button color
              child: InkWell(
                splashColor: Colors.cyan, // Splash color
                onTap: () => {handleReset(), handleStart()},
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Center(
                    child: Text(
                      "RESTART",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
