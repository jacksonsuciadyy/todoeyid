import 'package:flutter/material.dart';
import 'package:todoeyid/screens/tasksDateScreen.dart';

class TasksScreen extends StatelessWidget {
  final String profileName = "Jackson";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Hi, $profileName!',
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                // margin: EdgeInsets.only(top: 20.0),
                // padding: EdgeInsets.only(right: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: TasksDateScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
