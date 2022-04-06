import 'package:json_annotation/json_annotation.dart';

part 'register_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, createToJson: true, createFactory: true)
class RegisterInfo {
  String email;
  String password;
  String passwordConfirmation;

  RegisterInfo(this.email, this.password, this.passwordConfirmation);

  Map<String, dynamic> toJson() => _$RegisterInfoToJson(this);
}
