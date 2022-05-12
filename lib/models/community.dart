// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Community {
  String? name;

  Community({
    this.name,
  });

  Community copyWith({
    String? name,
  }) {
    return Community(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Community.fromJson(String source) => Community.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Community(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Community &&
      other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
