import 'package:flutter/material.dart';
import 'package:todoeyid/screens/calendarScreen.dart';
import 'package:todoeyid/screens/notificationScreen.dart';
import 'package:todoeyid/widgets/customButtomNavigationBar.dart';

import '../screens/addTaskScreen.dart';
import '../screens/settingsScreen.dart';
import '../screens/tasksScreen.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> _listWidgets = [
    TasksScreen(),
    Text('dummy widget'),
    SettingsScreen(),
  ];

  int _selectedIndex = 0;

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (builder) {
        // return new Container(
        //   height: MediaQuery.of(context).viewInsets.bottom,
        //   color: Colors.transparent, //could change this to Color(0xFF737373),
        //   //so you don't have to change MaterialApp canvasColor
        //   child: new Container(
        //     decoration: new BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: new BorderRadius.only(
        //             topLeft: const Radius.circular(10.0),
        //             topRight: const Radius.circular(10.0))),
        //     child: AddTaskScreen(),
        //   ),
        // );
        return AddTaskScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidgets[_selectedIndex],
      // floatingActionButton: _selectedIndex == 0
      //     ? FloatingActionButton(
      //         child: Icon(
      //           Icons.add,
      //           color: Colors.white,
      //         ),
      //         backgroundColor: Theme.of(context).primaryColor,
      //         onPressed: () {
      //           showDialog(
      //             context: context,
      //             builder: (BuildContext context) => SingleChildScrollView(
      //               child: Container(
      //                 padding: EdgeInsets.only(
      //                   bottom: MediaQuery.of(context).viewInsets.bottom,
      //                 ),
      //                 child: AddTaskScreen(),
      //               ),
      //             ),
      //           );
      //         },
      //       )
      //     : null,
      bottomNavigationBar: CustomBottomNavigationBar(
        backgroundColor: Colors.white,
        itemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex == 1 ? 2 : _selectedIndex,
        children: [
          CustomBottomNavigationItem(
            icon: Icons.list,
            label: 'Tasks',
          ),
          CustomBottomNavigationItem(
            icon: Icons.add,
            label: 'Tasks',
            isCenter: true,
            onTapCenter: _modalBottomSheetMenu,
            // onTapCenter: () {
            //   showDialog(
            //     context: context,
            //     builder: (BuildContext context) => SingleChildScrollView(
            //       child: Container(
            //         padding: EdgeInsets.only(
            //           bottom: MediaQuery.of(context).viewInsets.bottom,
            //         ),
            //         child: AddTaskScreen(),
            //       ),
            //     ),
            //   );
            // },
          ),
          CustomBottomNavigationItem(
            icon: Icons.settings,
            label: 'Settings',
          ),
        ],
        onChange: (newIndex) {
          if (newIndex != 1) {
            setState(() {
              _selectedIndex = newIndex;
            });
          }
        },
      ),
    );
  }
}
