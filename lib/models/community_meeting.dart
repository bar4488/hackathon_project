// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';

class CommunityMeeting {
  Community community;
  String name;
  String? id;
  DateTime start;
  DateTime end;
  String? description;
  String? location;
  List<String> members = [];

  Duration get duration => end.difference(start);
  bool get now =>
      DateTime.now().compareTo(start) != -1 &&
      DateTime.now().compareTo(end) != 1;

  CommunityMeeting({
    required this.community,
    required this.name,
    this.id,
    required this.start,
    required this.end,
    this.description,
    this.location,
    required this.members,
  });

  static CommunityMeeting fromMeeting(Community community, Meeting meeting) {
    return CommunityMeeting(
        community: community,
        name: meeting.name,
        start: meeting.start,
        end: meeting.end,
        members: meeting.members,
        id: meeting.id,
        location: meeting.location,
        description: meeting.description);
  }

  Meeting toMeeting() {
    return Meeting(
      name: name,
      start: start,
      end: end,
      members: members,
      description: description,
      id: id,
      location: location,
    );
  }

  CommunityMeeting copyWith({
    Community? community,
    String? name,
    String? id,
    DateTime? start,
    DateTime? end,
    String? topic,
    String? location,
    List<String>? members,
  }) {
    return CommunityMeeting(
      community: community ?? this.community,
      name: name ?? this.name,
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      description: topic ?? this.description,
      location: location ?? this.location,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'community': community.toMap(),
      'name': name,
      'id': id,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'topic': description,
      'location': location,
      'members': members,
    };
  }

  factory CommunityMeeting.fromMap(Map<String, dynamic> map) {
    return CommunityMeeting(
      community: Community.fromMap(map['community'] as Map<String, dynamic>),
      name: map['name'] as String,
      id: map['id'],
      start: DateTime.fromMillisecondsSinceEpoch(map['start'] as int),
      end: DateTime.fromMillisecondsSinceEpoch(map['end'] as int),
      description: map['topic'] != null ? map['topic'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      members: List<String>.from(
        (map['members'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommunityMeeting.fromJson(String source) =>
      CommunityMeeting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommunityMeeting(community: $community, name: $name, id: $id, start: $start, end: $end, topic: $description, location: $location, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommunityMeeting &&
        other.community == community &&
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
    return community.hashCode ^
        name.hashCode ^
        id.hashCode ^
        start.hashCode ^
        end.hashCode ^
        description.hashCode ^
        location.hashCode ^
        members.hashCode;
  }
}
