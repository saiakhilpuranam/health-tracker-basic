import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'package:health_track/screens/login_screen.dart';
import 'package:health_track/providers/reminder_provider.dart';
import 'package:health_track/providers/parameter_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(HealthTrack(localStorage: localStorage));
}

class HealthTrack extends StatelessWidget {
  final LocalStorage localStorage;
  const HealthTrack({Key? key, required this.localStorage}): super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: LoginScreen(),
  //     debugShowCheckedModeBanner: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReminderProvider(localStorage)),
        ChangeNotifierProvider(create: (_) => ParameterProvider(localStorage)),
      ],
      child: MaterialApp(
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
