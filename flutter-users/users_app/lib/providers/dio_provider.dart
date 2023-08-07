import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dio_provider.g.dart';

@riverpod
Dio dio(ref) {
  Dio dio = Dio(
      BaseOptions(baseUrl: 'https://assessment-users-backend.herokuapp.com'));
  return dio;
}
