import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:users_app/models/user_params.dart';
import 'package:users_app/repositories/user_repository.dart';
import '../models/user.dart';
import 'mutation_provider.dart';
part 'users_provider.g.dart';

// @riverpod
// Future<List<User>> getAllUsers(GetAllUsersRef ref) async {
//   return ref.watch(usersRepositoryProvider).getAllUsers();
// }

@riverpod
class GetAllUsers extends _$GetAllUsers {
  @override
  FutureOr<List<User>> build() {
    return ref.watch(usersRepositoryProvider).getAllUsers();
  }

  void updateList(User user) {
    state = state.whenData((value) => value.map((e) {
          if (e.id == user.id) {
            return User(
                id: user.id,
                firstName: user.firstName,
                lastName: user.lastName,
                createdAt: user.createdAt,
                updatedAt: user.updatedAt,
                status: user.status == Status.active
                    ? Status.locked
                    : Status.active);
          }
          return e;
        }).toList());
  }
}

@riverpod
Future<User> getUserById(GetUserByIdRef ref, int userId) async {
  return ref.watch(usersRepositoryProvider).getUserById(userId);
}

final updateUserStatusMutation = MutationProvider.create<dynamic, User>(
  mutationFn: (ref, User user) async {
    await Future.delayed(const Duration(seconds: 2));
    return ref.read(usersRepositoryProvider).updateUserStatusBy(user);
  },
  onSuccess: (ref, __, user) async => ref.read(getAllUsersProvider.notifier).updateList(user),
);

MutationNotifierProvider<dynamic, User> updateUserStatusMutation2() {
return MutationProvider.create<dynamic, User>(
  mutationFn: (ref, User user) async {
    await Future.delayed(const Duration(seconds: 2));
    return ref.read(usersRepositoryProvider).updateUserStatusBy(user);
  },
  onSuccess: (ref, __, user) async => ref.read(getAllUsersProvider.notifier).updateList(user),
);
}

final deleteUserMutation = MutationProvider.create(
  mutationFn: (ref, int userId) =>
      ref.read(usersRepositoryProvider).deleteUser(userId),
  onSuccess: (ref, __, ___) async => ref.invalidate(getAllUsersProvider),
);

final editUserMutation = MutationProvider.create(
  mutationFn: (ref, EditUserParams params) =>
      ref.read(usersRepositoryProvider).editUser(params),
  onSuccess: (ref, __, ___) async => ref.invalidate(getAllUsersProvider),
);

final addUserMutation = MutationProvider.create(
  mutationFn: (ref, NewUserParams params) =>
      ref.read(usersRepositoryProvider).addUser(params),
  onSuccess: (ref, __, ___) async => ref.invalidate(getAllUsersProvider),
);
