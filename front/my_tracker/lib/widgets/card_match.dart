import 'package:flutter/material.dart';
import 'package:my_tracker/API/models/match_class.dart';
import 'package:my_tracker/API/delete_match.dart';
import 'package:my_tracker/API/edit_match.dart';

// MatchCard widget, used to display a match
class MatchCard extends StatefulWidget {
  final Function matchCallback;
  final Match match;

  MatchCard({required this.match, required this.matchCallback});

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
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.match.imageOfCharacter),
              ),
              SizedBox(width: 20),
              _buildMatchInfo(),
              _buildButtons(),
            ]
          ),
        ),
      )
    );
  }

// Builds the match info
  Column _buildMatchInfo() {
    List<String> _kda = widget.match.kda.split('/');
    double _averageKda;
    if (int.parse(_kda[1]) == 0) _averageKda = (int.parse(_kda[0]) + int.parse(_kda[2])).toDouble();
    else _averageKda = ((int.parse(_kda[0]) + int.parse(_kda[2])) / int.parse(_kda[1])).toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.match.typeOfMatch,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              ' - ',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              widget.match.dateOfMatch.toString().substring(0, 10),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 3),
            Icon(Icons.schedule, size: 14, color: Colors.grey[600]),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              widget.match.role,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              ' - ',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              widget.match.kda,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              ' - ',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              _averageKda.toStringAsFixed(2),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          width: 240,
          child: Text(
            widget.match.comment,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _handleEdit() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit comment'),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                children: [
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Comment',
                    ),
                    onChanged: (value) {
                      widget.match.comment = value;
                    },
                  ),
                ]
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Edit'),
              onPressed: () async {
                await editMatch(widget.match);
                widget.matchCallback(widget.match);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
// Builds the buttons
  Column _buildButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.edit, size: 14, color: Colors.white),
            onPressed: () {
              _handleEdit();
            },
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.delete, size: 14, color: Colors.white),
            onPressed: () async {
              await deleteMatch(widget.match);
              widget.matchCallback(widget.match);
            },
          ),
        ),
      ]
    );
  }
}