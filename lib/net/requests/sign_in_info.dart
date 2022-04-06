import 'package:json_annotation/json_annotation.dart';

part 'sign_in_info.g.dart';

@JsonSerializable()
class SignInInfo {
  String email;

  String password;

  SignInInfo(this.email, this.password);

  Map<String, dynamic> toJson() => _$SignInInfoToJson(this);
}
