import 'package:flutter/material.dart';
import 'DbHandler.dart';
import 'MyServiceReport.dart'; // Import your MyServiceReport class

class EditServiceTarget extends StatefulWidget {
  const EditServiceTarget({Key? key}) : super(key: key);

  @override
  _EditServiceTargetState createState() => _EditServiceTargetState();
}

class _EditServiceTargetState extends State<EditServiceTarget> {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceDescriptionController = TextEditingController();
  TextEditingController dateRangeController = TextEditingController();
  TextEditingController totalTargetHours=TextEditingController();
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    dateRangeController.text = 'Select Date Range';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Service Target'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: serviceNameController,
              decoration: const InputDecoration(
                labelText: 'Service Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: serviceDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Service Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
             const SizedBox(height: 10),
            TextField(
              controller: totalTargetHours,
              decoration: const InputDecoration(
                labelText: 'Target Hours',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                final DateTimeRange? picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                  initialDateRange: _selectedDateRange,
                );

                if (picked != null && picked != _selectedDateRange) {
                  setState(() {
                    _selectedDateRange = picked;
                    dateRangeController.text =
                        '${picked.start.toLocal()} to ${picked.end.toLocal()}';
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: dateRangeController,
                  decoration: const InputDecoration(
                    labelText: 'Target Date Range',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                // Handle edit service target logic here
                print("Service Name: ${serviceNameController.text}");
                print("Service Description: ${serviceDescriptionController.text}");
                if (_selectedDateRange != null) {
                  print("Target Date Range: ${_selectedDateRange!.start.toLocal()} to ${_selectedDateRange!.end.toLocal()}");
                    print("target_hours: ${totalTargetHours.text}");

                  // Prepare the data to be inserted
                  final serviceTarget = {
                    'service_name': serviceNameController.text,
                    'service_description': serviceDescriptionController.text,
                    'start_date': _selectedDateRange!.start.toLocal().toString(),
                    'end_date': _selectedDateRange!.end.toLocal().toString(),
                    'target_hours':totalTargetHours.text,
                  };

                  // Insert the data into the database
                  bool success = await DbHandler.instance.insertServiceTarget(serviceTarget) > 0;

                  if (success) {
                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Service target saved successfully')),
                    );

                    // Navigate to MyServiceReport
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyServiceReport()),
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to save service target')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a date range')),
                  );
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
