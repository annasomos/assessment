class UserParams {
  const UserParams({
    this.id,
    this.firstName,
    this.lastName,
    this.status,
  });
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? status;

  factory UserParams.fromJson(Map<String, dynamic> data) {
    return UserParams(
      id: data["id"] as int,
      firstName: data["first_name"] as String,
      lastName: data["last_name"] as String,
      status: data["status"] as String,
    );
  }
}
