import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:health_track/screens/registration_screen.dart';
import 'package:health_track/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Default credentials
  //final String defaultEmail = 'testuser@email.com';
  //final String defaultPassword = 'password123';
  // Credentials
  String userEmail = '';
  String userPassword = ''; 

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool validateForm() {
    if (userEmail!='' && userPassword!='') {
      return true;
    }
    return false;
  }

  Future<bool> authenticateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? usernames = prefs.getStringList('usernames');
    // Check if user email exists
    if(usernames == null){
      const snackBar = SnackBar(content: Text('Email is not registered!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    final userIdx = usernames.indexOf(userEmail);
    if(userIdx == -1) {
      debugPrint('No saved accounts yet!');
      const snackBar = SnackBar(content: Text('Email is not registered!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    // Load and check passwords
    List<String>? passwords = prefs.getStringList('passwords');
    final String storedPassword = passwords![userIdx];
    if(userPassword == storedPassword) {
      // Save current user
      await prefs.setString('currentUsername', usernames[userIdx]);
      // Show success notification
      debugPrint('Authentication successful!');
      const snackBar = SnackBar(content: Text('Authentication successful'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return true;
    }
    debugPrint('Authentication failed!');
    const snackBar = SnackBar(content: Text('Incorrect password!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }

  void _login() async {
    // Login logic goes here
    debugPrint("Login logic needs to be implemented.");
    debugPrint('Output from validation: ${validateForm()}');
    if (validateForm()) {
      //Authenticate user
      final bool authenticated = await authenticateUser();
      if (authenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF623CD7), Color(0xFF19025E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App name header
                const Text(
                  'HealthTrack',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // White space between header and email
                const SizedBox(height: 30),
                // Email text box
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.deepPurpleAccent),
                      hintText: 'Enter Email',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15,
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        userEmail = value!;
                      });
                    },
                  ),
                ),
                // White spacing between email and password
                const SizedBox(height: 20),
                // Password text box
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.deepPurpleAccent),
                      hintText: 'Enter Password',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15,
                      ),
                    ),
                    obscureText: true,
                    onChanged: (String? value) {
                      setState(() {
                        userPassword = value!;
                      });
                    },
                  ),
                ),
                // White spacing between password and login button
                const SizedBox(height: 30),
                // Login button
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAC5EFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 65, vertical: 20,
                    ),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // White space between login button and OR
                const SizedBox(height: 30),
                // OR
                const Text(
                  'OR',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                // White space between OR and sign up button
                const SizedBox(height: 30),
                // Sign up button
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 65, vertical: 20,
                    ),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}