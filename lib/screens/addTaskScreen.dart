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
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  var nameController = new TextEditingController();
  var descriptionController = new TextEditingController();
  var dateFieldController = new TextEditingController();
  var timeFieldController = new TextEditingController();

  _selectDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: _selectedDate,
    );
    if (date != null)
      setState(() {
        dateFieldController.text =
            DateFormat('dd MMM yyyy', 'en_US').format(date);
      });
  }

  _selectTime() async {
    TimeOfDay t =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (t != null)
      setState(() {
        timeFieldController.text =
            t.hour.toString() + ":" + t.minute.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Text(
                  'Add Task',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
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
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: timeFieldController,
                  onTap: _selectTime,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Choose Time',
                    hintStyle: TextStyle(letterSpacing: 2.0),
                    prefixIcon: Icon(Icons.access_time),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textColor: Colors.white,
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                  onPressed: () {
                    Provider.of<Tasks>(context, listen: false).addTask(
                      Task(
                        taskID: Uuid().v4(),
                        name: nameController.text,
                        taskDate: DateFormat("dd MMM yyyy hh:mm").parse(
                            dateFieldController.text +
                                " " +
                                timeFieldController.text),
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
