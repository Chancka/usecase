import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_tracker/API/models/match_class.dart';

Future<void> deleteMatch(Match match) async {
  final String apiUrl = 'http://localhost:4242/match/${match.id}';

  try {
    final response = await http.delete(Uri.parse(apiUrl));
    if (response.statusCode == 204) {
      print('Match successfully deleted from the API');
    } else {
      print('Error delete: ${response.statusCode}');
      throw Exception('Failed to delete match');
    }
  } catch (e) {
    print(e);
    throw Exception('Failed to delete match');
  }
}