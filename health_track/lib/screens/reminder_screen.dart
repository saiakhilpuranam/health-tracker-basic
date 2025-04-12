import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_track/models/reminder.dart';
import 'package:health_track/providers/reminder_provider.dart';

class AddReminderScreen extends StatefulWidget {
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  String reminderId = '';
  String medicine = '';
  //late Future<TimeOfDay?> reminderTime;
  TimeOfDay? reminderTime;
  int quantity = 0;
  String _reminderTimeText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF623CD7),
        title: const Text(
          'Add Reminder',
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Medicine Name
            TextFormField(
              decoration: InputDecoration(labelText: 'Medicine'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a medicine name';
                }
                return null;
              },
              onSaved: (value) => medicine = value!,
            ),
            // Quantity
            TextFormField(
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              validator:(value) {
                if (value==null || value.isEmpty) {
                  return 'Please enter the quantity';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter an integer quantity';
                }
                return null;
              },
              onSaved: (value) => quantity = int.parse(value!),
            ),
            SizedBox(height: 30),
            OutlinedButton(
              onPressed: () async {
                reminderTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  _reminderTimeText = reminderTime!.format(context);
                });
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 65, vertical: 20,
                ),
              ),
              child: const Text(
                'Set Time',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(height: 30),
            Text('Reminder Time: $_reminderTimeText'),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<ReminderProvider>(context, listen: false)
                    .addReminder(
                      Reminder(
                        id: DateTime.now().toString(),
                        medicine: medicine,
                        time: reminderTime,
                        quantity: quantity
                      )
                    );
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}