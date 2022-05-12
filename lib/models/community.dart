// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'meeting.dart';

class Community {
  String? id;
  String? name;
  List<Meeting> meetings;
  List<String>? subscribers;

  Community({
    this.id,
    this.name,
    required this.meetings,
    this.subscribers,
  });

  Community copyWith({
    String? id,
    String? name,
    List<Meeting>? meetings,
    List<String>? subscribers,
  }) {
    return Community(
      id: id ?? this.id,
      name: name ?? this.name,
      meetings: meetings ?? this.meetings,
      subscribers: subscribers ?? this.subscribers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'items': meetings.map((x) => x.toMap()).toList(),
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      meetings: map['items'] != null
          ? List<Meeting>.from(
              (map['items'] as List<Object?>).map<Meeting>(
                (x) => Meeting.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Community.fromJson(String source) =>
      Community.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Community(id: $id, name: $name, meetings: $meetings, subscribers: $subscribers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Community &&
        other.id == id &&
        other.name == name &&
        listEquals(other.meetings, meetings) &&
        listEquals(other.subscribers, subscribers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        meetings.hashCode ^
        subscribers.hashCode;
  }
}
