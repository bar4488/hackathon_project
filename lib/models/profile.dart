// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profile {
  String? name;
  String? description;
  String? degree;
  int? age;
  Profile({
    this.name,
    this.description,
    this.degree,
    this.age,
  });

  Profile copyWith({
    String? name,
    String? description,
    String? degree,
    int? age,
  }) {
    return Profile(
      name: name ?? this.name,
      description: description ?? this.description,
      degree: degree ?? this.degree,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'degree': degree,
      'age': age,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      degree: map['degree'] != null ? map['degree'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(name: $name, description: $description, degree: $degree, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.name == name &&
        other.description == description &&
        other.degree == degree &&
        other.age == age;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        degree.hashCode ^
        age.hashCode;
  }
}
