import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final String name;
  final String description;
  final DateTime dueDate;
  final bool isDone;
  final Function checkboxCallback;

  const TaskTile(
      {this.isDone,
      this.name,
      this.description,
      this.dueDate,
      this.checkboxCallback});

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
              Expanded(
                flex: 1,
                child: CircularCheckBox(
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                  value: isDone,
                  onChanged: checkboxCallback,
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(name,
                    style: TextStyle(
                      fontSize: 20,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  DateFormat('Hm', 'en_US').format(dueDate),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(''),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  child: Text(
                    description,
                    // textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 16,
                        decoration: isDone ? TextDecoration.lineThrough : null),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(''),
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
