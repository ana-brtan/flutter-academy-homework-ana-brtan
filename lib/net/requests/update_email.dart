import 'package:json_annotation/json_annotation.dart';

part 'update_email.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, createToJson: true, createFactory: true)
class UpdateEmail {
  String email;

  UpdateEmail(this.email);

  Map<String, dynamic> ToJson() => _$UpdateEmailToJson(this);
}
