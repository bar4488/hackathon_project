// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Subscriber {
  String id;
  String? name;
  Subscriber({
    required this.id,
    this.name,
  });

  Subscriber copyWith({
    String? id,
    String? name,
  }) {
    return Subscriber(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Subscriber.fromMap(Map<String, dynamic> map) {
    return Subscriber(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Subscriber.fromJson(String source) =>
      Subscriber.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Subscriber(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Subscriber && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
