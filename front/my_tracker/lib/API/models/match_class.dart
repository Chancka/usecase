import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Match {
  String? id;
  String resultOfMatch;
  String typeOfMatch;
  DateTime dateOfMatch;
  String imageOfCharacter;
  String kda;
  String role;
  String comment;

  Match({
    this.id,
    required this.resultOfMatch,
    required this.typeOfMatch,
    required this.dateOfMatch,
    required this.imageOfCharacter,
    required this.kda,
    required this.role,
    required this.comment,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['_id'] ?? '',
      resultOfMatch: json['resultOfMatch'] ?? '',
      typeOfMatch: json['typeOfMatch'] ?? '',
      dateOfMatch: DateTime.parse(json['dateOfMatch']),
      imageOfCharacter: json['imageOfCharacter'] ?? '',
      kda: json['kda'] ?? '',
      role: json['role'] ?? '',
      comment: json['comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resultOfMatch': resultOfMatch,
      'typeOfMatch': typeOfMatch,
      'dateOfMatch': dateOfMatch.toIso8601String(),
      'imageOfCharacter': imageOfCharacter,
      'kda': kda,
      'role': role,
      'comment': comment,
    };
  }
}