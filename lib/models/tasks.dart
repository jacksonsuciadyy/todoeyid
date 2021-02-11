import 'package:flutter/material.dart';
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
      taskDate: DateTime.now(),
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
      taskDate: DateTime.now(),
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

  List<Task> get tasks {
    _tasks.sort((a, b) => b.taskDate.compareTo(a.taskDate));
    return [..._tasks];
  }

  int get length {
    return _tasks.length;
  }

  void addTask(Task task) {
    _tasks.add(task);
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
