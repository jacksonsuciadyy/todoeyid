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
            onTapCenter: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: AddTaskScreen(),
                  ),
                ),
              );
            },
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
