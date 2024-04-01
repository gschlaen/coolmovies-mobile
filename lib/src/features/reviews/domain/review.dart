// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Review {
  final String id;
  final String title;
  final String body;
  final int rating;
  final String userReviewerId;

  Review({
    required this.id,
    required this.title,
    required this.body,
    required this.rating,
    required this.userReviewerId,
  });

  Review copyWith({
    String? id,
    String? title,
    String? body,
    int? rating,
    String? userReviewerId,
  }) {
    return Review(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      rating: rating ?? this.rating,
      userReviewerId: userReviewerId ?? this.userReviewerId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'rating': rating,
      'userReviewerId': userReviewerId,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      rating: map['rating'] as int,
      userReviewerId: map['userReviewerId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(id: $id, title: $title, body: $body, rating: $rating, userReviewerId: $userReviewerId)';
  }

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.body == body &&
        other.rating == rating &&
        other.userReviewerId == userReviewerId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        rating.hashCode ^
        userReviewerId.hashCode;
  }
}
