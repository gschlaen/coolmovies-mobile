// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Movie {
  Movie({
    required this.id,
    required this.imgUrl,
    required this.movieDirectorId,
    required this.userCreatorId,
    required this.title,
    required this.releaseDate,
    required this.nodeId,
    required this.creator,
  });

  final String id;
  final String imgUrl;
  final String movieDirectorId;
  final String userCreatorId;
  final String title;
  final DateTime releaseDate;
  final String nodeId;
  final User creator;

  Movie copyWith({
    String? id,
    String? imgUrl,
    String? movieDirectorId,
    String? userCreatorId,
    String? title,
    DateTime? releaseDate,
    String? nodeId,
    User? creator,
  }) {
    return Movie(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      movieDirectorId: movieDirectorId ?? this.movieDirectorId,
      userCreatorId: userCreatorId ?? this.userCreatorId,
      title: title ?? this.title,
      releaseDate: releaseDate ?? this.releaseDate,
      nodeId: nodeId ?? this.nodeId,
      creator: creator ?? this.creator,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imgUrl': imgUrl,
      'movieDirectorId': movieDirectorId,
      'userCreatorId': userCreatorId,
      'title': title,
      'releaseDate': releaseDate.millisecondsSinceEpoch,
      'nodeId': nodeId,
      'userByUserCreatorId': creator.toMap(),
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as String,
      imgUrl: map['imgUrl'] as String,
      movieDirectorId: map['movieDirectorId'] as String,
      userCreatorId: map['userCreatorId'] as String,
      title: map['title'] as String,
      releaseDate: DateTime.parse(map['releaseDate'] as String),
      nodeId: map['nodeId'] as String,
      creator: User.fromMap(map['userByUserCreatorId'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Movie(id: $id, imgUrl: $imgUrl, movieDirectorId: $movieDirectorId, userCreatorId: $userCreatorId, title: $title, releaseDate: $releaseDate, nodeId: $nodeId, creator: $creator)';
  }

  @override
  bool operator ==(covariant Movie other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imgUrl == imgUrl &&
        other.movieDirectorId == movieDirectorId &&
        other.userCreatorId == userCreatorId &&
        other.title == title &&
        other.releaseDate == releaseDate &&
        other.nodeId == nodeId &&
        other.creator == creator;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imgUrl.hashCode ^
        movieDirectorId.hashCode ^
        userCreatorId.hashCode ^
        title.hashCode ^
        releaseDate.hashCode ^
        nodeId.hashCode ^
        creator.hashCode;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.nodeId,
  });

  final String id;
  final String name;
  final String nodeId;

  User copyWith({
    String? id,
    String? name,
    String? nodeId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      nodeId: nodeId ?? this.nodeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'nodeId': nodeId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      nodeId: map['nodeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, name: $name, nodeId: $nodeId)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.nodeId == nodeId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ nodeId.hashCode;
}
