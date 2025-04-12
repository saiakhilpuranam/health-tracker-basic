import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  //final _nameController = TextEditingController();
  //final _passwordController = TextEditingController();
  //double _age = 60;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  double _age = 21;

  // User data
  late String? currentUsername;
  late List<String>? usernames;
  late List<String>? passwords;
  late List<String>? names;
  late List<String>? ages;
  late int userIdx;

  Future<bool> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUsername = prefs.getString('currentUsername');
    usernames = prefs.getStringList('usernames');
    passwords = prefs.getStringList('passwords');
    names = prefs.getStringList('names');
    ages = prefs.getStringList('ages');

    debugPrint('Loaded shared preferences');
    //debugPrint(usernames.toString());
    userIdx = usernames!.indexOf(currentUsername!);
    debugPrint('userIdx: $userIdx');

    //_nameController = TextEditingController(text: names![userIdx]);
    setState(() {
      _nameController.text = names![userIdx];
      _passwordController.text = passwords![userIdx];
      _age = double.parse(ages![userIdx]);
    });

    return true;
  }

  @override
  void initState() {
    super.initState();
    debugPrint('Calling _loadUserData');
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool validateForm() {
    if(_nameController.text!='' && _passwordController.text!='') {
      return true;
    }
    return false;
  }

  void _save() async {
    names![userIdx] = _nameController.text;
    passwords![userIdx] = _passwordController.text;
    ages![userIdx] = _age.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('names', names!);
    await prefs.setStringList('passwords', passwords!);
    await prefs.setStringList('ages', ages!);
    debugPrint('Saved data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF623CD7),
        title: const Text(
          'Profile',
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
              // White space between Name and Password
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
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAC5EFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Save',
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