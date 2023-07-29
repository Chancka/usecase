import 'package:flutter/material.dart';
import 'package:my_tracker/views/home_view.dart';

void main() => runApp(MyTracker());

// MyTracker widget, the root of the app
class MyTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}


