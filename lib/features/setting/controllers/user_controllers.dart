import 'package:finals_fe/features/setting/data/user_repository_impl.dart';
import 'package:finals_fe/features/setting/domain/entities/technicians_model.dart';
import 'package:finals_fe/features/setting/domain/entities/user_status_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controllers.g.dart';

@riverpod
Future<UserStatusModel> userStatusController(Ref ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  final result = await userRepository.getUserStatus();
  return result.fold((error) => throw Exception(error), (userStatus) => userStatus);
}

@riverpod
Future<List<TechniciansModel>> techniciansController(Ref ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  final result = await userRepository.getTechnicians();
  return result.fold((error) => throw Exception(error), (technicians) => technicians);
}
