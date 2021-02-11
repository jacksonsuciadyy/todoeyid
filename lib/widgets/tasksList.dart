import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoeyid/models/tasks.dart';
import 'package:todoeyid/widgets/taskTile.dart';

class TasksList extends StatelessWidget {
  // List<Task> tasks = [
  //   Task(name: 'Task 1'),
  //   Task(name: 'Task 2'),
  //   Task(name: 'Task 3'),
  // ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Tasks>(
      builder: (ctx, tasksData, _) => Container(
        child: Center(
          child: ListView.builder(
            itemCount: tasksData.length,
            itemBuilder: (ctx, i) {
              final task = tasksData.tasks[i];
              return TaskTile(
                name: task.name,
                description: task.description,
                dueDate: task.dueDate,
                isDone: task.isDone,
                checkboxCallback: (bool checkboxState) {
                  tasksData.updateTask(task.taskID);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
