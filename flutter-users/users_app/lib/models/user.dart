import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

enum Status { locked, active }

@JsonSerializable()
class User {
  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.status,
      required this.createdAt,
      required this.updatedAt});


  final int id;
  @JsonKey()
  final String firstName;
  @JsonKey()
  final String lastName;
  @JsonKey()
  final Status status;
  @JsonKey()
  final DateTime createdAt;
  @JsonKey()
  final DateTime updatedAt;


  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  factory User.fromJsonString(String jsonString) =>
      _$UserFromJson(json.decode(jsonString) as Map<String, dynamic>);

  // factory User.fromJson(Map<String, dynamic> data) {
  //   return User(
  //     id: data["id"] as int,
  //     firstName: data["first_name"] as String,
  //     lastName: data["last_name"] as String,
  //     status: data["status"] as String,
  //     createdAt: data["created_at"] as String,
  //     updatedAt: data["updated_at"] as String,
  //   );
  // }
}
