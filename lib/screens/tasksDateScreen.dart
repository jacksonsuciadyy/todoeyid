import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoeyid/helpers/dbHelper.dart';
import 'package:todoeyid/models/tasks.dart';
import 'package:todoeyid/widgets/taskTile.dart';

class TasksDateScreen extends StatefulWidget {
  @override
  _TasksDateScreenState createState() => _TasksDateScreenState();
}

class _TasksDateScreenState extends State<TasksDateScreen> {
  // List<String> _tasksDate = [];
  // List<Task> _tasks = [];
  // bool _isInit = true;

  // List<Widget> _tasksData(BuildContext context, String dateTime) {
  //   List<Widget> tasks = [];
  //   getTasksFromDB(dateTime).then((tasksData) {
  //     for (var task in tasksData) {
  //       tasks.add(
  //         TaskTile(
  //           name: task.name,
  //           taskDate: task.taskDate,
  //           isDone: task.isDone,
  //           checkboxCallback: (bool checkboxState) {
  //             Provider.of<Tasks>(context, listen: false)
  //                 .updateTask(task.taskID);
  //           },
  //         ),
  //       );
  //     }
  //   });

  //   return tasks;
  // }

  // void getTasksDateFromDB() async {
  //   _tasksDate = await Provider.of<Tasks>(context).getDates();
  // }

  Future<List<Task>> getTasksFromDB(String taskDate) async {
    return await Provider.of<Tasks>(context).getTasksWithDate(taskDate);
  }

  showAlertDialog(BuildContext context, String taskDate) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Yes",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onPressed: () {
        Provider.of<Tasks>(context, listen: false).deleteTaskFromDate(taskDate);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Delete",
        style: TextStyle(fontSize: 24.0),
      ),
      content: RichText(
        text: new TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: new TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            new TextSpan(
                text: 'Are you sure want to delete all of the Tasks in '),
            new TextSpan(
              text: '$taskDate ',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            new TextSpan(text: '?'),
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   // List<String> _tasksDate = Provider.of<Tasks>(context).getDates();
  //   return ListView.builder(
  //     itemCount: _tasksDate.length,
  //     itemBuilder: (context, i) {
  //       return Column(
  //         children: [
  //           Center(
  //             child: InkWell(
  //               onTap: () {
  //                 showAlertDialog(context, _tasksDate[i]);
  //               },
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                     color: Theme.of(context).primaryColor,
  //                     borderRadius: BorderRadius.circular(20)),
  //                 padding:
  //                     EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  //                 margin: EdgeInsets.symmetric(vertical: 10.0),
  //                 child: Text(
  //                   _tasksDate[i],
  //                   style: new TextStyle(
  //                     fontSize: 14.0,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Column(
  //             children: _tasksData(context, _tasksDate[i]),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  // getTasksDate() async {
  //   final dataList = await DBHelper.getTasksDate('tasks');
  //   // print(dataList);
  //   return dataList;
  // }

  // getTasksDataFromDate(String dateTime) async {
  //   final dataList = await DBHelper.getTasksDataWithDate('tasks', dateTime);
  //   return dataList;
  // }

  @override
  Widget build(BuildContext context) {
    // List<String> _tasksDate = Provider.of<Tasks>(context).getDates();
    return FutureBuilder(
      // future: Provider.of<Tasks>(context, listen: false).getDates(),
      future: Provider.of<Tasks>(context).getTasksDate(),
      builder: (ctx, ss) {
        // if (ss.hasData)
        //   return Text(ss.data.toString());
        // else
        //   return Text("No Data");
        if (!ss.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          return ListView.builder(
            itemCount: ss.data.length,
            itemBuilder: (context, i) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        showAlertDialog(context, ss.data[i]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          DateFormat('EEE, dd MMMM yy', 'en_US').format(
                              DateFormat('yyyy-MM-ddTHH:mm:ss.mmmZ')
                                  .parse(ss.data[i]['taskDate'])),
                          style: new TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Column(
                  //   children: _tasksData(context, ss.data[i]['taskDate']),
                  // )
                  FutureBuilder(
                    future: Provider.of<Tasks>(context, listen: false)
                        .getTasksDataFromDate(ss.data[i]['taskDate']),
                    builder: (ctx, ssTask) {
                      if (!ssTask.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: ssTask.data.length,
                          itemBuilder: (ctx, it) {
                            // print(ssTask.data[it]['taskDate']);
                            return TaskTile(
                              name: ssTask.data[it]['name'],
                              taskDate: DateFormat('yyyy-MM-ddTHH:mm:ss.mmmZ')
                                  .parse(ssTask.data[it]['taskDate']),
                              isDone:
                                  ssTask.data[it]['isDone'] == 0 ? false : true,
                              checkboxCallback: (bool checkboxState) {
                                Provider.of<Tasks>(context, listen: false)
                                    .updateTask(ssTask.data[it]['taskID']);
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
