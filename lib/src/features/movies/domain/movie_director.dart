// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MovieDirector {
  MovieDirector({
    required this.id,
    required this.name,
    required this.age,
  });

  final String id;
  final String name;
  final int age;

  MovieDirector copyWith({
    String? id,
    String? name,
    int? age,
  }) {
    return MovieDirector(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
    };
  }

  factory MovieDirector.fromMap(Map<String, dynamic> map) {
    return MovieDirector(
      id: map['id'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDirector.fromJson(String source) =>
      MovieDirector.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MovieDirector(id: $id, name: $name, age: $age)';

  @override
  bool operator ==(covariant MovieDirector other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.age == age;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ age.hashCode;
}
