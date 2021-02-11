import 'package:flutter/material.dart';
import 'package:todoeyid/widgets/tasksList.dart';

class TasksScreen extends StatelessWidget {
  final String profileName = "Jackson";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(top: 40.0),
              padding: EdgeInsets.only(right: 15.0),
              child: TasksList(),
            ),
          ),
        ],
      ),
    );
  }
}
