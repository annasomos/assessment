import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/models/user_params.dart';
import 'package:users_app/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:users_app/providers/dio_provider.dart';
part 'user_repository.g.dart';

@riverpod
UsersRepository usersRepository(UsersRepositoryRef ref) => UsersRepository(ref);

class UsersRepository {
  UsersRepository(this.ref);

  final Ref ref;
  Dio get dio => ref.read(dioProvider);

  get updateStatusBy => null;

  Future<List<User>> getAllUsers() async {
    final res = await dio.get('/users.json');
    return res.data.map((user) => User.fromJson(user)).toList().cast<User>();
  }

  Future<Response<dynamic>> updateUserStatusBy(User user) async {
    final res = await dio.put('/users/${user.id}.json', data: {
      'status': user.status == 'active' ? 'locked' : 'active',
    });
    return res;
  }

  Future<Response<dynamic>> editUser(UserParams params) async {
    final res = await dio.put('/users/${params.id}.json', data: {
      'first_name': params.firstName,
      'last_name': params.lastName,
    });
    return res;
  }

  Future<Response<dynamic>> deleteUser(int userId) async {
    final res = await dio.delete('/users/$userId.json');
    return res;
  }

  Future<Response<dynamic>> addUser(UserParams params) async {
    return await dio.post('/users.json', data: {
      'first_name': params.firstName,
      'last_name': params.lastName,
      'status': 'active',
    });
  }

  Future<User> getUserById(int userId) async {
    final res = await dio.get('/users/$userId.json');
    return User.fromJson(res.data);
  }
}
