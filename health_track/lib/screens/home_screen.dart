import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:health_track/screens/profile_screen.dart';
import 'package:health_track/screens/login_screen.dart';
import 'package:health_track/screens/notifications_screen.dart';
import 'package:health_track/screens/reminder_screen.dart';
import 'package:health_track/providers/reminder_provider.dart';
import 'package:health_track/screens/parameter_screen.dart';
import 'package:health_track/models/parameter.dart';
import 'package:health_track/providers/parameter_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState(); 
}

class _HomeScreenState extends State<HomeScreen> 
  with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HealthTrack'),
        backgroundColor: Color(0xFF623CD7),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Reminders'),
            Tab(text: 'Monitor'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF623CD7)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Color(0xFF623CD7)),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => ProfileScreen(),)
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.person, color: Color(0xFF623CD7)),
              title: Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => NotificationsScreen(),)
                );
              }
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xFF623CD7)),
              title: Text('Sign out'),
              onTap: () {
                const snackBar = SnackBar(content: Text('Sign out successful!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // Sign out by pushing to login screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen())
                );
              }
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildReminderTab(context),
          buildMonitorTab(context),
        ],
      ),
    );
  }

  Widget buildReminderTab(BuildContext context) {
    return Consumer<ReminderProvider>(
      builder: (context, provider, child) {
        Widget addReminderButton = ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder:(context) => AddReminderScreen()),
          ),
          child: Text('Add reminder'),
        );
        // When the list is empty
        if(provider.reminders.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Align(alignment: Alignment.topCenter, child: addReminderButton),
              SizedBox(height: 100),
              Align(alignment: Alignment.center, child: Text("No reminders yet!")),
            ],
          );
        }
        return Column(
          children: [
            SizedBox(height: 30),
            addReminderButton,
            SizedBox(height:30),
            ListView.builder(
              shrinkWrap: true,
              itemCount: provider.reminders.length,
              itemBuilder: (context, index) {
                final reminder = provider.reminders[index];
                return Dismissible(
                  key: Key(reminder.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    provider.deleteReminder(reminder.id);
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Color(0xFF3B3636)),
                  ),
                  child: Card(
                    color: Color(0xFFEFC0E5),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: ListTile(
                      title: Text(reminder.medicine.toString()),
                      subtitle: Text(
                        'Quantity: ${reminder.quantity}\nTime: ${reminder.time!.format(context)}'
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          provider.deleteReminder(reminder.id);
                        },
                      ),
                    ),
                  ),
                );
              },
            )
          ]
        );
      }
    );
  }

  Widget buildMonitorTab(BuildContext context) {
    return Consumer<ParameterProvider>(
      builder: (context, provider, child) {
        Widget addParameterButton = ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder:(context) => AddParameterScreen()),
          ),
          child: Text('Add parameter'),
        );
        // When the list is empty
        if(provider.parameters.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Align(alignment: Alignment.topCenter, child: addParameterButton),
              SizedBox(height: 100),
              Align(alignment: Alignment.center, child: Text("No parameters yet!")),
            ],
          );
        }
        return Column(
          children: [
            SizedBox(height: 30),
            addParameterButton,
            SizedBox(height:30),
            ListView.builder(
              shrinkWrap: true,
              itemCount: provider.parameters.length,
              itemBuilder: (context, index) {
                return parameterContainer(context, provider, index);
              },
            )
          ]
        );
      }
    );
  }


  Widget parameterContainer(BuildContext context, ParameterProvider provider, int index) {
    final parameter = provider.parameters[index];
    final TextEditingController valueController = TextEditingController();

    return Dismissible(
      key: Key(parameter.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        provider.deleteParameter(parameter.id);
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, color: Color(0xFF3B3636)),
      ),
      child: Card(
        color: Color(0xFFEFC0E5),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column( 
          children: [
            cardHeader(provider, parameter),
            parameter.values.isNotEmpty ? plotParameterValues(parameter) : SizedBox(height:5),
            addParameterValueButton(context, provider, parameter, valueController),
          ]
        )
      ),
    );
  }

  Widget cardHeader(ParameterProvider provider, Parameter parameter) {
    return ListTile(
      title: Text(parameter.name),
      subtitle: Text(
        parameter.values.isNotEmpty ? 'Lastest value: ${parameter.values.last}': 'Add a value to start tracking'
      ),
      isThreeLine: true,
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          provider.deleteParameter(parameter.id);
        },
      ),
    );
  }

  Widget plotParameterValues(Parameter parameter) {
    List<FlSpot> spots = [];
    for (int i=0; i<parameter.values.length; i++) {
      spots.add(FlSpot(i+1, parameter.values[i]));
    }
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        width: double.infinity,
        height: 100.0,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                barWidth: 3,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
                spots: spots,
              ),
            ],
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
          ),
        ),
      ),
    );
  }

  Widget addParameterValueButton(
    BuildContext context,
    ParameterProvider provider,
    Parameter parameter,
    TextEditingController valueController) {
    return OutlinedButton(
      onPressed: () async {
        return addParameterValueDialog(context, provider, parameter, valueController);
      },
      child: Text('Add value'),
    );
  }

  Future<dynamic> addParameterValueDialog(
    BuildContext context,
    ParameterProvider provider,
    Parameter parameter,
    TextEditingController valueController) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add value'),
          content: TextField(
            controller: valueController,
            decoration: InputDecoration(hintText: 'Value'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if(double.tryParse(valueController.text) != null) {
                provider.addParameterValue(
                  parameter.id,
                  double.parse(valueController.text));
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }
}

