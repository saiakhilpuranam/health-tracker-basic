import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  double _age = 60;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool validateForm() {
    if(_nameController.text!='' && _emailController.text!='' && _passwordController.text!='') {
      return true;
    }
    return false;
  }

  Future<bool> createAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? usernames = prefs.getStringList('usernames');
    List<String>? passwords = prefs.getStringList('passwords');
    List<String>? names = prefs.getStringList('names');
    List<String>? ages = prefs.getStringList('ages');

    if (usernames!=null) {
      if (usernames.contains(_emailController.text)) {
        return false;
      } else {
        usernames.add(_emailController.text);
      }
    } else {
      usernames = [_emailController.text];
    }

    if (passwords!=null) {
      passwords.add(_passwordController.text);
    } else {
      passwords = [_passwordController.text];
    }

    if (names!=null) {
      names.add(_nameController.text);
    } else {
      names = [_nameController.text];
    }

    if (ages!=null) {
      ages.add(_age.toString());
    } else {
      ages = [_age.toString()];
    }

    await prefs.setStringList('usernames', usernames);
    await prefs.setStringList('passwords', passwords);
    await prefs.setStringList('names', names);
    await prefs.setStringList('ages', ages);

    return true;
  }

  void _register() async {
    // Implement registration logic here
    debugPrint("Registration logic is to be implemented!");
    debugPrint("Output from validation: ${validateForm()}");
    if(validateForm()) {
      // Save user details and move to login page
      await createAccount();
      debugPrint('Account created!');
      const snackBar = SnackBar(content: Text('Account creation successful'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF623CD7),
        title: const Text(
          'Register',
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              _buildInputField(_nameController, 'Name', Icons.person),
              // White space between Name and Email
              const SizedBox(height: 25),
              // Email field
              _buildInputField(_emailController, 'Email', Icons.email),
              // White space between Email and Password
              const SizedBox(height: 25),
              // Password field
              _buildInputField(_passwordController, 'Password', Icons.lock),
              // White space between Password and Age header
              const SizedBox(height:25),
              // Age header
              Text(
                'Age: ${_age.round()}',
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              // Age slider
              Slider(
                value: _age,
                min: 21,
                max: 100,
                divisions: 79,
                activeColor: Color(0xFF623CD7),
                inactiveColor: Colors.black,
                onChanged: (double value) {
                  setState(() {
                    _age = value;
                  });
                }
              ),
              // White space between age slider and register button
              const SizedBox(height: 100),
              // Register button
              Center(
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAC5EFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String hint,
    IconData icon
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Color(0xFF575757)),
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        ),
      ),
    );
  }
}