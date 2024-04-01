// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Movie {
  Movie({
    required this.id,
    required this.imgUrl,
    required this.movieDirectorId,
    required this.title,
    required this.releaseDate,
  });

  final String id;
  final String imgUrl;
  final String movieDirectorId;
  final String title;
  final String releaseDate;

  Movie copyWith({
    String? id,
    String? imgUrl,
    String? movieDirectorId,
    String? title,
    String? releaseDate,
  }) {
    return Movie(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      movieDirectorId: movieDirectorId ?? this.movieDirectorId,
      title: title ?? this.title,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imgUrl': imgUrl,
      'movieDirectorId': movieDirectorId,
      'title': title,
      'releaseDate': releaseDate,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as String,
      imgUrl: map['imgUrl'] as String,
      movieDirectorId: map['movieDirectorId'] as String,
      title: map['title'] as String,
      releaseDate: map['releaseDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Movie(id: $id, imgUrl: $imgUrl, movieDirectorId: $movieDirectorId, title: $title, releaseDate: $releaseDate)';
  }

  @override
  bool operator ==(covariant Movie other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imgUrl == imgUrl &&
        other.movieDirectorId == movieDirectorId &&
        other.title == title &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imgUrl.hashCode ^
        movieDirectorId.hashCode ^
        title.hashCode ^
        releaseDate.hashCode;
  }
}
