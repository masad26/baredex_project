// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);

import 'dart:convert';

Settings settingsFromJson(String str) => Settings.fromJson(json.decode(str));

String settingsToJson(Settings data) => json.encode(data.toJson());

class Settings {
  bool error;
  dynamic message;
  List<Datum> data;

  Settings({
    this.error,
    this.message,
    this.data,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        error: json["error"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String key;
  String value;
  dynamic notes;

  Datum({
    this.id,
    this.key,
    this.value,
    this.notes,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "notes": notes,
      };
}
