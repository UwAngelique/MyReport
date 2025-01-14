import 'package:flutter/material.dart';
import 'MyServiceReport.dart';
import 'DbHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServiceReport extends StatefulWidget {
  const MyServiceReport({super.key});

  @override
  _MyServiceReportState createState() => _MyServiceReportState();
}

class _MyServiceReportState extends State<MyServiceReport> {
  String targetHours = 'Loading...'; 
  double _progress = 0.0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Simulate progress for demonstration purposes
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _progress = 0.7; // 70% progress
      });
    });
  }
   Future<void> _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      // _navigateToLogin();
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear session data
    // _navigateToLogin();
  }

  // void _navigateToLogin() {
  //   Navigator.pushReplacement(
  //     context
  //     MaterialPageRoute(builder: (context) => const MyApp()),
  //   );
  // }
  Future<void> _loadTargetHours() async {
    try {
      List<Map<String, dynamic>> results = await DbHandler.instance.getServiceTargetsForCurrentMonth();
      if (results.isNotEmpty) {
        int totalHours = results.fold(0, (sum, row) => sum + (row['target_hours'] as int));
        setState(() {
          targetHours = '$totalHours hours';
        });
      } else {
        setState(() {
          targetHours = 'No data available';
        });
      }
    } catch (e) {
      print("Error loading target hours: $e");
      setState(() {
        targetHours = 'Error loading data';
      });
    }
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on selected index
    // For example, navigate to different pages
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Report'),
        backgroundColor: const Color(0xFF87CEEB),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Add margin to the left and right
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Total Hours Worked',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '30 hrs', // Example value
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Target Hours',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      targetHours, 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[300],
              color: const Color(0xFF87CEEB),
              minHeight: 10,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to report details screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF87CEEB), // Background color
                  ),
                  child: Text(
                    'View Report Details',
                    style: TextStyle(color: Colors.white), // Set text color
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to edit target screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF87CEEB), // Background color
                  ),
                  child: Text(
                    'Edit Service Target',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(), // Horizontal line separator
            const SizedBox(height: 10),
            const Text(
              'My Service Ministry',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4, // 40% of screen width
                  height: 150, // Fixed height
                  child: Card(
                    color: Colors.white, // Set the card color to white
                    elevation: 5, // Increased elevation for shadow effect
                    child: InkWell(
                      onTap: () {
                        // Navigate to add report screen
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.note_add, size: 40, color: Colors.black),
                          SizedBox(height: 10),
                          Text(
                            'Add Report',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4, // 40% of screen width
                  height: 150, // Fixed height
                  child: Card(
                    color: Colors.white, // Set the card color to white
                    elevation: 5, // Increased elevation for shadow effect
                    child: InkWell(
                      onTap: () {
                        // Navigate to add new person screen
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_add, size: 40, color: Colors.black),
                          SizedBox(height: 10),
                          Text(
                            'Add New Person',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4, // 40% of screen width
                  height: 150, // Fixed height
                  child: Card(
                    color: Colors.white, // Set the card color to white
                    elevation: 5, // Increased elevation for shadow effect
                    child: InkWell(
                      onTap: () {
                        // Navigate to add visit screen
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_location, size: 40, color: Colors.black),
                          SizedBox(height: 10),
                          Text(
                            'Add Visit',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4, // 40% of screen width
                  height: 150, // Fixed height
                  child: Card(
                    color: Colors.white, // Set the card color to white
                    elevation: 5, // Increased elevation for shadow effect
                    child: InkWell(
                      onTap: () {
                        // Navigate to add reminder screen
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.alarm_add, size: 40, color: Colors.black),
                          SizedBox(height: 10),
                          Text(
                            'Add Reminder',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Upcomings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Add your upcoming items here
            const Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50, // Adjust the width as needed
                      child: Icon(
                        Icons.notifications, // Choose an appropriate icon
                        size: 30,
                        color: Colors.blue, // Choose the color you prefer
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Reminders',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(), // Add Spacer to push the items to the ends
                    // Add your reminder items here
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Add your reminder items here
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Reminders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
        ],
      ),
    );
  }
}

abstract class MyServiceReportInterface {
  void openServiceReport(BuildContext context);
}

class MyServiceReportImpl implements MyServiceReportInterface {
  @override
  void openServiceReport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyServiceReport()),
    );
  }
}
