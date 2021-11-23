// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GoButton extends StatelessWidget {
  GoButton(this.handleStart, {Key? key}) : super(key: key);
  Function handleStart;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 158.0),
      child: ClipOval(
        child: Material(
          color: Colors.cyan, // Button color
          child: InkWell(
            splashColor: Colors.cyanAccent, // Splash color
            onTap: () => handleStart(),
            child: SizedBox(
              width: 250,
              height: 250,
              child: Center(
                child: Text(
                  "GO",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
