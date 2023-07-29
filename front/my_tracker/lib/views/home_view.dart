import 'package:flutter/material.dart';
import 'package:my_tracker/widgets/add_match.dart';

// HomeView widget, the home page of the app
class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tracker'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddMatch(),
          );
        },
        label: const Text('Add Match'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

