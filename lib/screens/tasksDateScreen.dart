import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoeyid/models/tasks.dart';
import 'package:todoeyid/widgets/taskTile.dart';

class TasksDateScreen extends StatefulWidget {
  @override
  _TasksDateScreenState createState() => _TasksDateScreenState();
}

class _TasksDateScreenState extends State<TasksDateScreen> {
  List<String> _tasksDate = [];
  List<Task> _tasks = [];
  bool _isInit = true;

  // List<Widget> _tasksData(BuildContext context, String dateTime) {
  //   // List<Widget> tasks = [];
  //   var tasksData = Provider.of<Tasks>(context).getTasksWithDate(dateTime);
  //   for (var task in tasksData) {
  //     tasks.add(
  //       TaskTile(
  //         name: task.name,
  //         taskDate: task.taskDate,
  //         isDone: task.isDone,
  //         checkboxCallback: (bool checkboxState) {
  //           Provider.of<Tasks>(context, listen: false).updateTask(task.taskID);
  //         },
  //       ),
  //     );
  //   }

  //   return tasks;
  // }

  void getTasksDateFromDB() async {
    _tasksDate = await Provider.of<Tasks>(context).getDates();
  }

  void getTasksFromDB(String taskDate) async {
    _tasks = await Provider.of<Tasks>(context).getTasksWithDate(taskDate);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _isInit = false;
      getTasksDateFromDB();
    }
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

  @override
  Widget build(BuildContext context) {
    // List<String> _tasksDate = Provider.of<Tasks>(context).getDates();
    return FutureBuilder(
      future: Provider.of<Tasks>(context, listen: false).getDates(),
      builder: (ctx, ss) => ss.connectionState == ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<Tasks>(
              child: Center(
                child: Text('Got no tasks yet, start adding some!'),
              ),
              builder: (ctx, tasks, ch) => tasks.tasksdate.length <= 0
                  ? ch
                  : FutureBuilder(
                      future:
                          Provider.of<Tasks>(context, listen: false).getDates(),
                      builder: (ctx, ss) =>
                          ss.connectionState == ConnectionState.waiting
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(''),
                    ),
            ),
    );
  }
}
