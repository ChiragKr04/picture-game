import 'dart:convert';

import 'package:picture_game/models/picture_model.dart';

FirebaseModel firebaseModelFromJson(String str) =>
    FirebaseModel.fromJson(json.decode(str));

String firebaseModelToJson(FirebaseModel data) => json.encode(data.toJson());

class FirebaseModel {
  FirebaseModel({
    required this.word,
    required this.results,
  });

  String word;
  List<Result> results;

  FirebaseModel copyWith({
    String? word,
    List<Result>? results,
  }) =>
      FirebaseModel(
        word: word ?? this.word,
        results: results ?? this.results,
      );

  factory FirebaseModel.fromJson(Map<String, dynamic> json) => FirebaseModel(
        word: json["word"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
