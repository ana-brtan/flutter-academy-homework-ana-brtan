import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String? imageUrl;

  User(this.id, this.email, this.imageUrl);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
