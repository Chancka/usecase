import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_tracker/API/models/match_class.dart';

Future<void> postMatch(Match match) async {
  final String apiUrl = 'http://localhost:4242/history';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(match.toJson()),
    );
    if (response.statusCode == 201) {
      print('Match successfully sent to the API');
    } else {
      print('Error post: ${response.statusCode}');
      throw Exception('Failed to send match');
    }
  } catch (e) {
    throw Exception('Failed to send match');
  }
}
