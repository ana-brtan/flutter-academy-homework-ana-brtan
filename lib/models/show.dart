import 'package:json_annotation/json_annotation.dart';

part 'show.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Show {
  String id;
  String title;
  String description;
  @JsonKey(name: "no_of_reviews")
  int numOfReviews;
  double averageRating;
  String? imageUrl;

  Show(this.id, this.title, this.description, this.numOfReviews, this.averageRating, this.imageUrl);

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);
}
