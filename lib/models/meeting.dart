// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Meeting {
  String? name;
  int? id;

  Meeting({
    this.name,
    required this.id,
  });

  Meeting copyWith({
    String? name,
    int? id,
  }) {
    return Meeting(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meeting.fromJson(String source) =>
      Meeting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Meeting(name: $name, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Meeting && other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
