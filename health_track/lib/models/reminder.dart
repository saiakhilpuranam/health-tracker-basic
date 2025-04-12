import 'package:flutter/material.dart';

class Reminder {
  final String id;
  final String medicine;
  final TimeOfDay? time;
  final int quantity;

  Reminder({
    required this.id,
    required this.medicine,
    required this.time,
    required this.quantity
  });

  factory Reminder.fromJson(Map<String, dynamic>json) {
    String tod = json['time'];
    TimeOfDay time = TimeOfDay(
      hour:int.parse(tod.split(":")[0]),
      minute: int.parse(tod.split(":")[1]),
    );
    return Reminder(
      id: json['id'],
      medicine: json['medicine'],
      time: time,
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicine': medicine,
      'time': '${time!.hour}:${time!.minute}',//time.toString(),
      'quantity': quantity,
    };
  }
}