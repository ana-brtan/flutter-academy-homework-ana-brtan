import 'package:json_annotation/json_annotation.dart';

part 'update_profile_photo.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, createToJson: true, createFactory: true)
class UpdateProfilePhoto {
  String imagePath;

  UpdateProfilePhoto(this.imagePath);

  Map<String, dynamic> ToJson() => _$UpdateProfilePhotoToJson(this);
}
