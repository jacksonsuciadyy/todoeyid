import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../helpers/dbHelper.dart';

class Task {
  String taskID;
  String name;
  DateTime taskDate;
  bool isDone;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'taskID': taskID,
      'name': name,
      'taskDate': taskDate,
      'isDone': isDone ? 1 : 0
    };
    if (taskID != null) {
      map['taskID'] = taskID;
    }
    return map;
  }

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

  Future<List<String>> getDates() async {
    final dataList = await DBHelper.getTasksData('tasks');
    _tasks = dataList
        .map(
          (item) => Task(
            taskID: item['id'],
            name: item['title'],
            taskDate: item['taskDate'],
            isDone: item['isDone'],
          ),
        )
        .toList();

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

  List<String> get tasksdate {
    return [..._dates];
  }

  // List<Task> get tasks {
  //   // _tasks.sort((a, b) => b.taskDate.compareTo(a.taskDate));
  //   return [..._tasks];
  // }

  Future<List<Task>> getTasksWithDate(String taskDate) async {
    final dataList = await DBHelper.getTasksDataWithDate(
        'tasks', DateFormat('EEE, dd MMMM yy', 'en_US').parse(taskDate));
    _tasks = dataList
        .map(
          (item) => Task(
            taskID: item['id'],
            name: item['title'],
            taskDate: item['taskDate'],
            isDone: item['isDone'],
          ),
        )
        .toList();
    return [..._tasks];
  }

  int get length {
    return _tasks.length;
  }

  // void addTask(Task task) {
  //   _tasks.add(task);
  //   notifyListeners();
  // }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    notifyListeners();
    DBHelper.insertData('tasks', {
      'taskID': task.taskID,
      'name': task.name,
      'taskDate': task.taskDate,
      'isDone': task.isDone,
      // 'isDone': task.isDone ? 1 : 0,
    });
  }

  Future<void> deleteTaskFromDate(String taskDate) async {
    List<Task> tasksToDelete = [
      ..._tasks.where((task) =>
          DateFormat('EEE, dd MMMM yy', 'en_US').format(task.taskDate) ==
          taskDate)
    ];
    for (var task in tasksToDelete) {
      _tasks.remove(task);
      DBHelper.deleteData('tasks', task.taskID);
    }
    notifyListeners();
  }

  // void deleteTask(String taskID) {
  //   int indexToDelete = _tasks.indexWhere((task) => task.taskID == taskID);
  //   _tasks.removeAt(indexToDelete);
  //   notifyListeners();
  // }

  void updateTask(String taskID) {
    int indexToUpdate = _tasks.indexWhere((task) => task.taskID == taskID);
    Task oldTask = _tasks[indexToUpdate];
    oldTask.isDone = !oldTask.isDone;
    notifyListeners();
    // DBHelper.insertData('tasks', {
    //   'taskID': task.taskID,
    //   'name': task.name,
    //   'taskDate': task.taskDate,
    //   'isDone': task.isDone,
    //   // 'isDone': task.isDone ? 1 : 0,
    // });
  }
}
