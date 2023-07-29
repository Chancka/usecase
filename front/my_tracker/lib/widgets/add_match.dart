import 'package:flutter/material.dart';
import 'package:my_tracker/API/models/match_class.dart';
import 'package:my_tracker/API/post_match.dart';

// AddMatch widget, a dialog that allows the user to add a match
class AddMatch extends StatefulWidget {
  final Function addMatchCallback;

  AddMatch({required this.addMatchCallback});

  @override
  State<StatefulWidget> createState() => _AddMatchState();
}

class _AddMatchState extends State<AddMatch> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _resultOfMatchController = TextEditingController();
  TextEditingController typeOfMatchController = TextEditingController();
  TextEditingController _characterController = TextEditingController();
  TextEditingController _kdaController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Match'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _resultOfMatchController,
              decoration: InputDecoration(
                labelText: 'Result',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a result';
                }
                return null;
              },
            ),
            TextFormField(
              controller: typeOfMatchController,
              decoration: InputDecoration(
                labelText: 'Type of Match',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a type of match';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _characterController,
              decoration: InputDecoration(
                labelText: 'Name of character',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a name of character';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _kdaController,
              decoration: InputDecoration(
                labelText: 'KDA',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a KDA';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _roleController,
              decoration: InputDecoration(
                labelText: 'Role',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a role';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Comment',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a comment';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              Match match = Match(
                resultOfMatch: _resultOfMatchController.text,
                typeOfMatch: typeOfMatchController.text,
                imageOfCharacter: _characterController.text,
                kda: _kdaController.text,
                role: _roleController.text,
                comment: _commentController.text,
                dateOfMatch: DateTime.now(),
              );
              await postMatch(match);
              widget.addMatchCallback(match);
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}