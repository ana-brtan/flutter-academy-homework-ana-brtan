import 'package:json_annotation/json_annotation.dart';

part 'add_review.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, createToJson: true, createFactory: true)
class AddReview {
  String comment;
  int rating;
  String show_id;

  AddReview(this.comment, this.rating, this.show_id);

  Map<String, dynamic> toJson() => _$AddReviewToJson(this);
}
