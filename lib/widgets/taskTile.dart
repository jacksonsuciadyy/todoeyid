import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final String name;
  final DateTime taskDate;
  final bool isDone;
  final Function checkboxCallback;

  const TaskTile(
      {this.isDone, this.name, this.taskDate, this.checkboxCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(
      //       width: 1,
      //       color: Colors.grey[100],
      //     ),
      //   ),
      // ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: CircularCheckBox(
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                  value: isDone,
                  onChanged: checkboxCallback,
                ),
              ),
              Flexible(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colors.grey.withOpacity(0.2),
                      color: Colors.redAccent.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
