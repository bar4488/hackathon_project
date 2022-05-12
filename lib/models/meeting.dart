// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Meeting {
  String name;
  int? id;
  DateTime start;
  DateTime end;
  String? topic;
  Meeting({
    required this.name,
    this.id,
    required this.start,
    required this.end,
    this.topic,
  });

  Meeting copyWith({
    String? name,
    int? id,
    DateTime? start,
    DateTime? end,
    String? topic,
  }) {
    return Meeting(
      name: name ?? this.name,
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      topic: topic ?? this.topic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'topic': topic,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      name: map['name'] as String,
      id: map['id'] != null ? map['id'] as int : null,
      start: DateTime.fromMillisecondsSinceEpoch(map['start'] as int),
      end: DateTime.fromMillisecondsSinceEpoch(map['end'] as int),
      topic: map['topic'] != null ? map['topic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meeting.fromJson(String source) =>
      Meeting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Meeting(name: $name, id: $id, start: $start, end: $end, topic: $topic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Meeting &&
        other.name == name &&
        other.id == id &&
        other.start == start &&
        other.end == end &&
        other.topic == topic;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        start.hashCode ^
        end.hashCode ^
        topic.hashCode;
  }
}
