import 'package:flutter/material.dart';
import 'package:my_tracker/widgets/add_match.dart';
import 'package:my_tracker/API/models/match_class.dart';
import 'package:my_tracker/API/get_history.dart';
import 'package:my_tracker/API/models/history_class.dart';
import 'package:my_tracker/widgets/card_match.dart';

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

  void _matchCallback(Match match) async {
    List<Match> matches = await getHistory();
    setState(() {
      _matches = matches;
    });
    int _defeatCounter = 0;
    for (int i = 0; i < _matches.length; i++) {
      if (_matches[i].resultOfMatch == 'Defeat') _defeatCounter++;
      else _defeatCounter = 0;
      if (_defeatCounter == 3) {
        showDialog(
          context: context,
          builder: (BuildContext context) => _showMessageOfShame(),
        );
        break;
      }
    }
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
            builder: (BuildContext context) => AddMatch(matchCallback : _matchCallback),
          );
        },
        label: const Text('Add Match'),
        icon: const Icon(Icons.add),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 2.3,

        ),
        itemCount: _matches.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: MatchCard(match: _matches[index], matchCallback: _matchCallback),
          );
        },
      ),
    );
  }

  AlertDialog _showMessageOfShame() {
    return AlertDialog(
      title: Text('Shame on you!'),
      content: Text("T'es aussi éclaté au sol que ma grand mère"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}

