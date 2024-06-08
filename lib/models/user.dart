import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  String surname;
  String phone;
  String workPlace;
  String login;
  String password;
  String role;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.phone,
    required this.workPlace,
    required this.login,
    required this.password,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}
