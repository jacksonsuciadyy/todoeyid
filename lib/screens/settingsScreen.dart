import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Profile Name',
                labelStyle: TextStyle(
                  fontSize: 14.0,
                  letterSpacing: 2.0,
                ),
                // border: OutlineInputBorder(
                //   borderSide: BorderSide(
                //       color: Theme.of(context).primaryColor, width: 1.0),
                //   borderRadius: BorderRadius.circular(10),
                // ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 14.0, letterSpacing: 2.0),
                ),
                Switch(
                  activeColor: Theme.of(context).primaryColor,
                  value: _isDarkMode,
                  onChanged: (newValue) {
                    setState(() {
                      _isDarkMode = newValue;
                    });
                  },
                ),
              ],
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
                'Save',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Save Successfully!'),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
