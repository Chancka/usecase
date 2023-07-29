import 'package:flutter/material.dart';
import 'package:my_tracker/widgets/add_match.dart';
import 'package:my_tracker/API/models/match_class.dart';
import 'package:my_tracker/API/get_history.dart';
import 'package:my_tracker/API/models/history_class.dart';

// HomeView widget, the home page of the app
class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Match> _matches = [];

  @override
  void initState() {
    super.initState();
    getHistory().then((value) {
      setState(() {
        _matches = value;
      });
    });
  }

  void _addMatchCallback(Match match) {
    setState(() {
      _matches.add(match);
    });
  }
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
            builder: (BuildContext context) => AddMatch(addMatchCallback : _addMatchCallback),
          );
        },
        label: const Text('Add Match'),
        icon: const Icon(Icons.add),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2),
        ),
        itemCount: _matches.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 300,
            width: 200,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: Column(
                children: [ 
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_matches[index].imageOfCharacter),
                    ),
                    title: Text(_matches[index].typeOfMatch),
                    subtitle: Text(_matches[index].resultOfMatch),
                    trailing: Text(_matches[index].kda),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

