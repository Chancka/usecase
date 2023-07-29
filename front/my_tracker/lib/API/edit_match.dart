import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_tracker/API/models/match_class.dart';

Future<void> editMatch(Match match) async {
  final String apiUrl = 'http://localhost:4242/match/${match.id}';

  try {
    final response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(match.toJson()),
    );
    if (response.statusCode == 200) {
      print('Match successfully edited from the API');
    } else {
      print('Error edit: ${response.statusCode}');
      throw Exception('Failed to edit match');
    }
  } catch (e) {
    print(e);
    throw Exception('Failed to edit match');
  }
}