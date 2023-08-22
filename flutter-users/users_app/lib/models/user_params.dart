class NewUserParams {
  const NewUserParams({
    required this.firstName,
    required this.lastName,
    required this.status,
  });
  final String? firstName;
  final String? lastName;
  final String? status;

  factory NewUserParams.fromJson(Map<String, dynamic> data) {
    return NewUserParams(
      firstName: data["first_name"] as String,
      lastName: data["last_name"] as String,
      status: data["status"] as String,
    );
  }
}


class EditUserParams {
  const EditUserParams({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.status,
  });
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? status;

  factory EditUserParams.fromJson(Map<String, dynamic> data) {
    return EditUserParams(
      id: data["id"] as int,
      firstName: data["first_name"] as String,
      lastName: data["last_name"] as String,
      status: data["status"] as String,
    );
  }
}
