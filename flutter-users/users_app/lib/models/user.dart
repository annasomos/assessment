import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
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
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'status')
  final Status status;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => _$UserToJson(this);
  String getFormattedCreatedAt() =>
      'Created at: ${DateFormat.yMMMEd().format(createdAt)}';
  String getFormattedUpdatedAt() => 'Last updated: ${DateFormat.yMMMEd().format(updatedAt)}';
  String getFullName() => '$firstName $lastName';

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
