import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_tracker/API/models/match_class.dart';

Future<List<Match>> getHistory() async {
  final String apiUrl = 'http://localhost:4242/history';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      print('History successfully received from the API');
      List<dynamic> body = jsonDecode(response.body);
      List<Match> matches = body.map((dynamic match) => Match.fromJson(match)).toList();
      return matches;
    } else {
      print('Error get: ${response.statusCode}');
      throw Exception('Failed to load history');
    }
  } catch (e) {
    print(e);
    throw Exception('Failed to load history');
  }
}
