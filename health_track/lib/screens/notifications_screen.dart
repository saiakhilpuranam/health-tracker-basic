import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool enableReminders = true;

  void _savePreferences () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('reminderNotfications', enableReminders);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF623CD7),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Reminders',
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            Switch(
              value: enableReminders,
              activeColor: Color(0xFF623CD7),
              onChanged: (bool value) async{
                setState(() {
                  enableReminders = value;
                });
                _savePreferences();
              }
            ),
          ],
        ),
      )
    );
  }
}