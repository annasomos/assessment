import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:users_app/models/user_params.dart';
import 'package:users_app/repositories/user_repository.dart';
import '../models/user.dart';
import 'mutation_provider.dart';
part 'users_provider.g.dart';

@riverpod
Future<List<User>> getAllUsers(GetAllUsersRef ref) async {
  return ref.watch(usersRepositoryProvider).getAllUsers();
}

@riverpod
Future<User> getUserById(GetUserByIdRef ref, int userId) async {
  return ref.watch(usersRepositoryProvider).getUserById(userId);
}

final updateUserStatusMutation = MutationProvider.create(
  mutationFn: (ref, User user) =>
      ref.read(usersRepositoryProvider).updateUserStatusBy(user),
  onSuccess: (ref, __, ___) async => ref.invalidate(getAllUsersProvider),
);

final deleteUserMutation = MutationProvider.create(
  mutationFn: (ref, int userId) =>
      ref.read(usersRepositoryProvider).deleteUser(userId),
  onSuccess: (ref, __, ___) async => ref.invalidate(getAllUsersProvider),
);

final editUserMutation = MutationProvider.create(
  mutationFn: (ref, UserParams params) =>
      ref.read(usersRepositoryProvider).editUser(params),
  onSuccess: (ref, __, ___) async => ref.invalidate(getAllUsersProvider),
);

final addUserMutation = MutationProvider.create(
  mutationFn: (ref, UserParams params) =>
      ref.read(usersRepositoryProvider).addUser(params),
  onSuccess: (ref, __, ___) async => ref.invalidate(getAllUsersProvider),
);
