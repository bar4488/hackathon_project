// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:collection/collection.dart';

class Meeting {
  String name;
  String? id;
  DateTime start;
  DateTime end;
  String? description;
  String? location;
  List<String> members = [];

  Meeting({
    required this.name,
    this.id,
    required this.start,
    required this.end,
    this.description,
    this.location,
    required this.members,
  });

  Meeting copyWith({
    String? name,
    String? id,
    DateTime? start,
    DateTime? end,
    String? description,
    String? location,
    List<String>? members,
  }) {
    return Meeting(
      name: name ?? this.name,
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      description: description ?? this.description,
      location: location ?? this.location,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'description': description,
      'location': location,
      'members': members,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    var columnValues = map["column_values"] as List<dynamic>;
    var members = columnValues[0]["text"] as String;
    var start = columnValues[1]["text"] as String;
    var end = columnValues[2]["text"] as String;
    var description = columnValues[3]["text"] as String;
    var location = columnValues[4]["text"] as String;
    var f = DateFormat("yyyy-MM-dd hh:mm");
    return Meeting(
      name: map['name'] as String,
      id: map['id'],
      start: start.isEmpty ? DateTime.now() : f.parse(start),
      end: end.isEmpty ? DateTime.now() : f.parse(end),
      members: members.split(", "),
      description: description,
      location: location,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meeting.fromJson(String source) =>
      Meeting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Meeting(name: $name, id: $id, start: $start, end: $end, description: $description, location: $location, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Meeting &&
        other.name == name &&
        other.id == id &&
        other.start == start &&
        other.end == end &&
        other.description == description &&
        other.location == location &&
        listEquals(other.members, members);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        start.hashCode ^
        end.hashCode ^
        description.hashCode ^
        location.hashCode ^
        members.hashCode;
  }
}
