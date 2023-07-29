import 'package:flutter/material.dart';
import 'package:my_tracker/API/models/match_class.dart';
import 'package:my_tracker/API/delete_match.dart';

class MatchCard extends StatefulWidget {
  final Function deleteMatchCallback;
  final Match match;

  MatchCard({required this.match, required this.deleteMatchCallback});

  @override
  _MatchCardState createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.match.resultOfMatch == 'Victory' ? Colors.green[200] : Colors.red[200],
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.match.imageOfCharacter),
            ),
            title: Row(
              children: [
                Text(
                  widget.match.role,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                Text(
                  widget.match.typeOfMatch,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  widget.match.resultOfMatch,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ], mainAxisAlignment: MainAxisAlignment.start,
            ),
            subtitle: Row(
              children: [
                Container(
                  width: 100,
                  child: Text(
                    widget.match.dateOfMatch.toString().substring(0, 10),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Container(
                  width: 300,
                  child: Text(
                    maxLines: 2,
                    widget.match.comment,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ], mainAxisAlignment: MainAxisAlignment.start,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await deleteMatch(widget.match);
                widget.deleteMatchCallback(widget.match);
              },
            ),
          ),
        ],
      ),
    );
  }
}