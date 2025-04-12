import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_track/models/reminder.dart';

class ReminderProvider with ChangeNotifier {

  final LocalStorage storage;

  String _username = '';

  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  ReminderProvider(this.storage) {
    _loadRemindersFromStorage();
  }

  void _loadRemindersFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('currentUsername')!;
    var storedReminders = storage.getItem('${_username}Reminders');
    if(storedReminders != null) {
      _reminders = List<Reminder>.from(
        (storedReminders as List).map((item) => Reminder.fromJson(item))
      );
      notifyListeners();
    }
  }

  void _saveRemindersToStorage() async {
    storage.setItem('${_username}Reminders', jsonEncode(_reminders.map((e)=>e.toJson()).toList()));
  }

  void addReminder(Reminder reminder) {
    _reminders.add(reminder);
    _saveRemindersToStorage();
    notifyListeners();
  }

  void addOrUpdateReminder(Reminder reminder) {
    int index = _reminders.indexWhere((e) => e.id == reminder.id);
    if(index != -1) {
      _reminders[index] = reminder;
    } else {
      _reminders.add(reminder);
    }
    _saveRemindersToStorage();
    notifyListeners();
  }

  void deleteReminder(String id) {
    _reminders.removeWhere((reminder) => reminder.id == id);
    _saveRemindersToStorage();
    notifyListeners();
  }
}