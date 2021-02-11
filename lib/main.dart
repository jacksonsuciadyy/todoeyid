import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoeyid/models/tasks.dart';
import 'package:todoeyid/screens/navigationScreen.dart';
import 'package:todoeyid/screens/tasksScreen.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Tasks(),
      child: MaterialApp(
        title: 'ToDoey.ID',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: NavigationScreen(),
      ),
    );
  }
}
