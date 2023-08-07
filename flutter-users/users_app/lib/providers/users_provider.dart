
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

final updateUserStatusMutation = MutationStateNotifierProvider((ref) =>
    MutationProvider<dynamic, User>(
        mutationFn: ref.read(usersRepositoryProvider).updateUserStatusBy,
        onSuccess: (_, __) => ref.invalidate(getAllUsersProvider)));

final deleteUserMutation = MutationStateNotifierProvider((ref) =>
    MutationProvider<dynamic, int>(
        mutationFn: ref.read(usersRepositoryProvider).deleteUser,
        onSuccess: (_, __) => ref.invalidate(getAllUsersProvider)));

final editUserMutation = MutationStateNotifierProvider((ref) =>
    MutationProvider<dynamic, UserParams>(
        mutationFn: ref.read(usersRepositoryProvider).editUser,
        onSuccess: (_, __) => ref.invalidate(getAllUsersProvider)));

final addUserMutation = MutationStateNotifierProvider((ref) =>
    MutationProvider<void, UserParams>(
        mutationFn: ref.read(usersRepositoryProvider).addUser,
        onSuccess: (_, __) => ref.invalidate(getAllUsersProvider)));