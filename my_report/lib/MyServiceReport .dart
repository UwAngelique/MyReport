import 'package:flutter/material.dart';

class MyServiceReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Report'),
      ),
      body: Center(
        child: Text(
          'Your Service Report UI goes here',
          style: TextStyle(fontSize: 24),
        ),
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
