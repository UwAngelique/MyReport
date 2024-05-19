import 'package:flutter/material.dart';

class MyServiceReport extends StatefulWidget {
  @override
  _MyServiceReportState createState() => _MyServiceReportState();
}

class _MyServiceReportState extends State<MyServiceReport> {
  double _progress = 0.0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Simulate progress for demonstration purposes
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _progress = 0.7; // 70% progress
      });
    });
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
        title: Text('Service Report'),
        backgroundColor: Color(0xFF87CEEB),
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
                      '50 hrs', // Example value
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[300],
              color: Color(0xFF87CEEB),
              minHeight: 10,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to report details screen
                  },
                  child: Text(
                    'View Report Details',
                    style: TextStyle(color: Colors.white), // Set text color
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF87CEEB), // Background color
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to edit target screen
                  },
                  child: Text(
                    'Edit Service Target',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF87CEEB), // Background color
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(), // Horizontal line separator
            SizedBox(height: 10),
            Text(
              'My Service Ministry',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.note_add, size: 40, color: Color(0xFF87CEEB)),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_add, size: 40, color: Color(0xFF87CEEB)),
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
            SizedBox(height: 10),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_location, size: 40, color: Color(0xFF87CEEB)),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.alarm_add, size: 40, color: Color(0xFF87CEEB)),
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
            SizedBox(height: 20),
            Text(
              'Upcomings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Add your upcoming items here
            Card(
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50, // Adjust the width as needed
                      child: Icon(
                        Icons.notifications, // Choose an appropriate icon
                        size: 30,
                        color: Color(0xFF87CEEB), // Choose the color you prefer
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
            SizedBox(height: 30),
            // Add your reminder items here
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF87CEEB),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
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
