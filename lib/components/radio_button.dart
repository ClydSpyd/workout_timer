// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WorkoutRadioButton extends StatefulWidget {
  WorkoutRadioButton(
      this.title, this.idx, this.selectedIdx, this.updateSelected);

  final String title;
  final int idx;
  final int selectedIdx;
  Function updateSelected;

  @override
  State<WorkoutRadioButton> createState() => _WorkoutRadioButtonState();
}

class _WorkoutRadioButtonState extends State<WorkoutRadioButton> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.idx == widget.selectedIdx;
    return InkWell(
      onTap: () => widget.updateSelected(widget.idx),
      child: Row(
        children: [
          SizedBox(
            width: 250,
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : null,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected ? Colors.orange : Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color:
                        isSelected ? Colors.grey.shade900 : Colors.grey[600]!,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
