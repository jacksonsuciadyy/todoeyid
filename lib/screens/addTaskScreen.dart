import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoeyid/models/tasks.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool _isAlreadySubmit = false;
  DateTime _selectedDate = DateTime.now();
  String _taskname = "";
  String _date = "";
  // TimeOfDay _selectedTime = TimeOfDay.now();

  FocusNode focusNode;

  var nameController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var dateFieldController = new TextEditingController();
  var timeFieldController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode = new FocusNode();

    // listen to focus changes
    // focusNode.addListener(
    //     () => print('focusNode updated: hasFocus: ${focusNode.hasFocus}'));
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  _selectDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: _selectedDate,
    );
    if (date != null)
      setState(() {
        _date = DateFormat('dd MMM yyyy', 'en_US').format(date);
        dateFieldController.text =
            DateFormat('dd MMM yyyy', 'en_US').format(date);
      });
  }

  // _selectTime() async {
  //   TimeOfDay t =
  //       await showTimePicker(context: context, initialTime: _selectedTime);
  //   if (t != null)
  //     setState(() {
  //       timeFieldController.text =
  //           t.hour.toString() + ":" + t.minute.toString();
  //     });
  // }

  void submitData() {
    setState(() {
      _isAlreadySubmit = true;
    });
    if (nameController.text.isNotEmpty && dateFieldController.text.isNotEmpty) {
      Provider.of<Tasks>(context, listen: false).addTask(
        Task(
          taskID: Uuid().v4(),
          name: nameController.text,
          taskDate: DateFormat("dd MMM yyyy")
              .parse(dateFieldController.text + " " + timeFieldController.text),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      padding: EdgeInsets.only(
          top: 20.0,
          right: 30.0,
          left: 30.0,
          bottom: 20 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Add Task',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            autofocus: true,
            focusNode: focusNode,
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Name',
              hintStyle: TextStyle(letterSpacing: 2.0),
              prefixIcon: Icon(Icons.content_paste),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (newTaskName) {
              setState(
                () {
                  _taskname = newTaskName;
                },
              );
            },
          ),
          if (_isAlreadySubmit && _taskname.isEmpty)
            Text(
              'Please input Task Name!',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          SizedBox(
            height: 20,
          ),
          // TextField(
          //   controller: descriptionController,
          //   maxLines: null,
          //   decoration: InputDecoration(
          //     hintText: 'Description',
          //     hintStyle: TextStyle(letterSpacing: 2.0),
          //     labelStyle: TextStyle(),
          //     prefixIcon: Icon(Icons.description),
          //     border: OutlineInputBorder(
          //       borderSide: BorderSide(
          //           color: Theme.of(context).primaryColor, width: 1.0),
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          TextField(
            controller: dateFieldController,
            onTap: _selectDate,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Choose Date',
              hintStyle: TextStyle(letterSpacing: 2.0),
              prefixIcon: Icon(Icons.today),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          if (_isAlreadySubmit && _date.isEmpty)
            Text(
              'Please input Date!',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          // SizedBox(
          //   height: 20,
          // ),
          // TextField(
          //   controller: timeFieldController,
          //   onTap: _selectTime,
          //   readOnly: true,
          //   decoration: InputDecoration(
          //     hintText: 'Choose Time',
          //     hintStyle: TextStyle(letterSpacing: 2.0),
          //     prefixIcon: Icon(Icons.access_time),
          //     border: OutlineInputBorder(
          //       borderSide: BorderSide(
          //           color: Theme.of(context).primaryColor, width: 1.0),
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textColor: Colors.white,
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 16, letterSpacing: 1.5),
              ),
              onPressed: submitData,
            ),
          ),
        ],
      ),
    );
  }
}
