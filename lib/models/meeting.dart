// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
    print(map);
    return Meeting(
      name: map['name'] as String,
      id: map['id'],
      //start: DateTime.fromMillisecondsSinceEpoch(map['start'] as int),
      //end: DateTime.fromMillisecondsSinceEpoch(map['end'] as int),
      start: DateTime.now(),
      end: DateTime.now(),
      description:
          map['description'] != null ? map['description'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      members: [],
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
