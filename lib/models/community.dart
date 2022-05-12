// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'meeting.dart';

class Community {
  int? id;
  String? name;
  List<Meeting> meetings;

  Community({
    this.name,
    this.id,
    required this.meetings,
  });

  Community copyWith({
    String? name,
    int? id,
    List<Meeting>? meetings,
  }) {
    return Community(
      name: name ?? this.name,
      id: id ?? this.id,
      meetings: meetings ?? this.meetings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'meetings': meetings.map((x) => x.toMap()).toList(),
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      meetings: List<Meeting>.from(
        (map['meetings'] as List<int>).map<Meeting>(
          (x) => Meeting.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Community.fromJson(String source) =>
      Community.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Community(name: $name, id: $id, meetings: $meetings)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Community &&
        other.name == name &&
        other.id == id &&
        listEquals(other.meetings, meetings);
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ meetings.hashCode;
}
