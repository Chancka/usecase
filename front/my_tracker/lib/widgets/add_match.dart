import 'package:flutter/material.dart';
import 'package:my_tracker/API/models/match_class.dart';
import 'package:my_tracker/API/post_match.dart';

List<String> arrayCharacter = [
  'gekko',
  'fade',
  'breach',
  'deadlock',
  'raze',
  'chamber',
  'kay/o',
  'skye',
  'cypher',
  'sova',
  'killjoy',
  'harbor',
  'viper',
  'phoenix',
  'astra',
  'brimstone',
  'neon',
  'yoru',
  'sage',
  'reyna',
  'omen',
  'jett',
];
// AddMatch widget, a dialog that allows the user to add a match
class AddMatch extends StatefulWidget {
  final Function addMatchCallback;

  AddMatch({required this.addMatchCallback});

  @override
  State<StatefulWidget> createState() => _AddMatchState();
}

class _AddMatchState extends State<AddMatch> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _characterController = TextEditingController();
  TextEditingController _kdaController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  String _resultOfMatch = 'Victory';
  String _typeOfMatch = 'Normal';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Match',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField(
                      value: _resultOfMatch,
                      items: [
                        DropdownMenuItem(
                          child: Text('Victory'),
                          value: 'Victory',
                        ),
                        DropdownMenuItem(
                          child: Text('Defeat'),
                          value: 'Defeat',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _resultOfMatch = value.toString();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Result of Match',
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a result of match';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      value: _typeOfMatch,
                      items: [
                        DropdownMenuItem(
                          child: Text('Ranked'),
                          value: 'Ranked',
                        ),
                        DropdownMenuItem(
                          child: Text('Normal'),
                          value: 'Normal',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _typeOfMatch = value.toString();
                        });
                      },
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
                        String _value = value.toString();
                        _value = _value.toLowerCase();
                        if (arrayCharacter.contains(_value) == false)
                          return 'Please enter a valid name of character';
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
                        String _value = value.toString();
                        List<String> _kda = _value.split('/');
                        if (_kda.length != 3) {
                          return 'Format of KDA must be x/x/x';
                        }
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a KDA';
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
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              String nameOfCharacter =
                                  _characterController.text;
                              nameOfCharacter = nameOfCharacter.toLowerCase();
                              Match match = Match(
                                resultOfMatch: _resultOfMatch,
                                typeOfMatch: _typeOfMatch,
                                imageOfCharacter: nameOfCharacter,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
