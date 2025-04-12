import 'package:flutter/material.dart';

class Parameter {
  String id;
  String name;
  List<double> values = [];

  Parameter({required this.id, required this.name, values}) {
    if (values != null) {
      this.values = values;
    }
  }

  void addValue(double value) {
    debugPrint('Trying to add $value to list');
    values.add(value);
    debugPrint('Value appended to parameter.');
  }

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      id: json['id'],
      name: json['name'],
      values: json['values'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'values': values,
    };
  }
}