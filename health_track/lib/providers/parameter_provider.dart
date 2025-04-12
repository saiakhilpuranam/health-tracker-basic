import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_track/models/parameter.dart';

class ParameterProvider with ChangeNotifier {

  final LocalStorage storage;
  List<Parameter> _parameters = [];
  List<Parameter> get parameters => _parameters;
  String _username = '';

  ParameterProvider(this.storage) {
    _loadParametersFromStorage();
  }

  void _loadParametersFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('currentUsername')!;
    var storedParameters = storage.getItem('${_username}Parameters');
    if(storedParameters != null) {
      _parameters = List<Parameter>.from(
        (storedParameters as List).map((item) => Parameter.fromJson(item))
      );
      notifyListeners();
    }
  }

  void _saveParametersToStorage() {
    storage.setItem('${_username}Parameters', jsonEncode(_parameters.map((e) => e.toJson()).toList()));
  }

  void addParameter(Parameter parameter) {
    _parameters.add(parameter);
    _saveParametersToStorage();
    notifyListeners();
  }

  void addOrUpdateParameter(Parameter parameter) {
    int index = _parameters.indexWhere((e) => e.id == parameter.id);
    if (index != -1) {
      _parameters[index] = parameter;
    } else {
      _parameters.add(parameter);
    }
    _saveParametersToStorage();
    notifyListeners();
  }

  void deleteParameter(String id) {
    _parameters.removeWhere((parameter) => parameter.id == id);
    _saveParametersToStorage();
    notifyListeners();
  }

  void addParameterValue(String parameterId, double value) {
    int index = _parameters.indexWhere((e) => e.id == parameterId);
    debugPrint('Going to add value for parameter: $index');
    _parameters[index].addValue(value);
    debugPrint('Added value to parameter in provider.');
    _saveParametersToStorage();
    notifyListeners();
  }
}