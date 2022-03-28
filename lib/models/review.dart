import 'package:json_annotation/json_annotation.dart';
import 'package:tv_shows/models/user.dart';

part 'review.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Review {
  String id;
  String comment;
  int rating;
  int showId;
  User user;

  Review(this.id, this.comment, this.rating, this.user, this.showId);

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
