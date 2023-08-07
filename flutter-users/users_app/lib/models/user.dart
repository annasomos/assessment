enum Status { locked, active }

class User {
  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  final int id;
  final String firstName;
  final String lastName;
  final String status;
  final String createdAt;
  final String updatedAt;

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data["id"] as int,
      firstName: data["first_name"] as String,
      lastName: data["last_name"] as String,
      status: data["status"] as String,
      createdAt: data["created_at"] as String,
      updatedAt: data["updated_at"] as String,
    );
  }
}
