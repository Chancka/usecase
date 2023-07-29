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
            builder: (BuildContext context) => AddMatch(addMatchCallback : _matchCallback),
          );
        },
        label: const Text('Add Match'),
        icon: const Icon(Icons.add),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
        ),
        itemCount: _matches.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: MatchCard(match: _matches[index], deleteMatchCallback: _matchCallback),
          );
        },
      ),
    );
  }
}

