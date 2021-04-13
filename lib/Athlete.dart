import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Athlete> parseAthletes(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Athlete>((json) => Athlete.fromJson(json)).toList();
}
  
  Future<List<Athlete>> fetchAthletes() async {
    final String apiUrl =
        "https://api.sportsdata.io/v3/mlb/stats/json/PlayerSeasonStats/2020?key=fa329ac2e3ce465e9db5a14b34ca9368";
    
    final result = await http.get(apiUrl);
  
    if (result.statusCode == 200) {
      return parseAthletes(result.body);
    } else {
      throw Exception("Failed to get Athletes");
    }
  }

  Future<List<Athlete>> fetchAthleteWAR() async {
    var currentDate = new DateTime.now();
    final String apiUrl = 'https://fly.sportsdata.io/v3/mlb/stats/json/PlayerGameStatsByDate/';
  }
  class Athlete  {
    final String name;
    final int playerID;
    final double fantasyPoints;
    final double warValue;
    Athlete(
        {@required this.name,
        @required this.playerID,
        @required this.fantasyPoints,
        @required this.warValue});
  
      double getWarValue(Map<String, dynamic> json)
    {
      // Call the Oracle
      return ;
    }

    factory Athlete.fromJson(Map<String, dynamic> json) {
      return Athlete(
        playerID: json['PlayerID'],
        name: json['Name'],
        fantasyPoints: json['FantasyPoints'],
        warValue: json['RunsBattedIn'] + json['']
      );
    }

}