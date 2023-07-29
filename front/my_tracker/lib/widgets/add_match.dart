import 'package:flutter/material.dart';
import 'package:my_tracker/widgets/date_picker.dart';

// AddMatch widget, a dialog that allows the user to add a match
class AddMatch extends StatefulWidget {
  // final Function addMatchCallback;

  // AddMatch({this.addMatchCallback});

  @override
  State<StatefulWidget> createState() => _AddMatchState();
}

class _AddMatchState extends State<AddMatch> {
  final _formKey = GlobalKey<FormState>();
  final _matchNameController = TextEditingController();
  final _matchDateController = TextEditingController();
  final _matchTimeController = TextEditingController();
  final _matchLocationController = TextEditingController();

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
              controller: _matchNameController,
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
              controller: _matchDateController,
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
            SizedBox(height: 10),
            DatePicker(),
            TextFormField(
              controller: _matchTimeController,
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
              controller: _matchLocationController,
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
              controller: _matchLocationController,
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
              controller: _matchLocationController,
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
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}