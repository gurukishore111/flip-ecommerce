import 'dart:convert';

class Rating {
  final String userId;
  final double rating;
  final String username;
  final String review;

  Rating({
    required this.userId,
    required this.rating,
    required this.username,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
      'username': username,
      'review': review,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      username: map['username'] ?? '',
      review: map['review'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
