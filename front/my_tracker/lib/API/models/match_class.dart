import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Match {
  String? id;
  String resultOfMatch;
  String typeOfMatch;
  String dateOfMatch;
  String imageOfCharacter;
  String kda;
  String role;
  String comment;
  String? nameOfCharacter;

  Match({
    this.id,
    required this.resultOfMatch,
    required this.typeOfMatch,
    required this.dateOfMatch,
    required this.imageOfCharacter,
    required this.kda,
    required this.role,
    required this.comment,
    this.nameOfCharacter,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['_id'] ?? '',
      resultOfMatch: json['resultOfMatch'] ?? '',
      typeOfMatch: json['typeOfMatch'] ?? '',
      dateOfMatch: (json['dateOfMatch']),
      imageOfCharacter: json['imageOfCharacter'] ?? '',
      kda: json['kda'] ?? '',
      role: json['role'] ?? '',
      comment: json['comment'] ?? '',
      nameOfCharacter: json['nameOfCharacter'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resultOfMatch': resultOfMatch,
      'typeOfMatch': typeOfMatch,
      'dateOfMatch': dateOfMatch,
      'imageOfCharacter': imageOfCharacter,
      'kda': kda,
      'role': role,
      'comment': comment,
      'nameOfCharacter': nameOfCharacter,
    };
  }
}