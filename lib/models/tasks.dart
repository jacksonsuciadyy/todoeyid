import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Task {
  String taskID;
  String name;
  DateTime taskDate;
  bool isDone;

  Task({
    @required this.taskID,
    this.name,
    this.taskDate,
    this.isDone = false,
  });
}

class Tasks extends ChangeNotifier {
  List<Task> _tasks = [
    Task(
      taskID: Uuid().v4(),
      name: 'Task 1',
      taskDate: DateTime.now().add(Duration(days: 2)),
    ),
    Task(
      taskID: Uuid().v4(),
      name: 'Task 2',
      taskDate: DateTime.now(),
    ),
    Task(
      taskID: Uuid().v4(),
      name:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      taskDate: DateTime.now().add(Duration(days: 1)),
    ),
    Task(
      taskID: Uuid().v4(),
      name: 'Task 4',
      taskDate: DateTime.now(),
    ),
    Task(
      taskID: Uuid().v4(),
      name: 'Task 5',
      taskDate: DateTime.now(),
    ),
  ];

  List<String> _dates = [];

  List<String> getDates() {
    _tasks.sort((a, b) => a.taskDate.compareTo(b.taskDate));

    _dates.clear();

    for (var task in _tasks) {
      if (!_dates.contains(
          DateFormat('EEE, dd MMMM yy', 'en_US').format(task.taskDate)))
        _dates
            .add(DateFormat('EEE, dd MMMM yy', 'en_US').format(task.taskDate));
    }

    // for (var date in _dates) {
    //   print(date);
    // }
    // print('\n');

    return _dates;

    // groupByDate.forEach((date, list) {
    //   print('$date:');
    // });
  }

  List<Task> get tasks {
    // _tasks.sort((a, b) => b.taskDate.compareTo(a.taskDate));
    return [..._tasks];
  }

  List<Task> getTasksWithDate(String taskDate) {
    return [
      ..._tasks.where((task) =>
          DateFormat('EEE, dd MMMM yy', 'en_US').format(task.taskDate) ==
          taskDate)
    ];
  }

  int get length {
    return _tasks.length;
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTaskFromDate(String taskDate) {
    List<Task> tasksToDelete = [
      ...tasks.where((task) =>
          DateFormat('EEE, dd MMMM yy', 'en_US').format(task.taskDate) ==
          taskDate)
    ];
    for (var task in tasksToDelete) {
      _tasks.remove(task);
    }
    notifyListeners();
  }

  void deleteTask(String taskID) {
    int indexToDelete = _tasks.indexWhere((task) => task.taskID == taskID);
    _tasks.removeAt(indexToDelete);
    notifyListeners();
  }

  void updateTask(String taskID) {
    int indexToUpdate = _tasks.indexWhere((task) => task.taskID == taskID);
    Task oldTask = _tasks[indexToUpdate];
    oldTask.isDone = !oldTask.isDone;
    notifyListeners();
  }
}
