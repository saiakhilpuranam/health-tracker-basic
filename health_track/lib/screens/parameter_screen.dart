import 'package:flutter/material.dart';
import 'package:health_track/providers/parameter_provider.dart';
import 'package:provider/provider.dart';
import 'package:health_track/models/parameter.dart';

class AddParameterScreen extends StatefulWidget {
  const AddParameterScreen({super.key});
  @override
  _AddParameterScreenState createState() => _AddParameterScreenState();
}

class _AddParameterScreenState extends State<AddParameterScreen> {
  final _formKey = GlobalKey<FormState>();
  String parameterId = '';
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF623CD7),
        title: const Text(
          'Add Parameter',
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
            SizedBox(height: 30),
            // Parameter Name
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name for the parameter';
                }
                return null;
              },
              onSaved: (value) => name = value!,
            ),
            // White space between Name and save button
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Provider.of<ParameterProvider>(context, listen: false)
                    .addParameter(
                      Parameter(
                        id: DateTime.now().toString(),
                        name: name,
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
