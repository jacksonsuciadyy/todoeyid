import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Task {
  String taskID;
  String name;
  String description;
  DateTime dueDate;
  bool isDone;

  Task({
    @required this.taskID,
    this.name,
    this.description = '',
    this.dueDate,
    this.isDone = false,
  });
}

class Tasks extends ChangeNotifier {
  List<Task> _tasks = [
    Task(
      taskID: Uuid().v4(),
      name: 'Task 1',
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore",
      dueDate: DateTime.now(),
    ),
    Task(
      taskID: Uuid().v4(),
      name: 'Task 2',
      description: "This is Description",
      dueDate: DateTime.now(),
    ),
    Task(
      taskID: Uuid().v4(),
      name: 'Task 3',
      dueDate: DateTime.now(),
    ),
    Task(
      taskID: Uuid().v4(),
      name: 'Task 4',
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore",
      dueDate: DateTime.now(),
    ),
    Task(
      taskID: Uuid().v4(),
      name: 'Task 5',
      description: "This is Description",
      dueDate: DateTime.now(),
    ),
  ];

  List<Task> get tasks {
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
