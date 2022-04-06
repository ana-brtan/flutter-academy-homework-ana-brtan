import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  String id;
  String email;
  String? imageUrl;

  User(this.id, this.email, this.imageUrl);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
