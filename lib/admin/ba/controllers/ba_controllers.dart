import 'package:finals_fe/admin/ba/data/ba_repository_impl.dart';
import 'package:finals_fe/admin/ba/domain/entities/ba_detail_model.dart';
import 'package:finals_fe/admin/ba/domain/entities/ba_params.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ba_controllers.g.dart';

@riverpod
Future<BaDetailModel> getBaDetail(Ref ref, int baId) async {
  final repository = ref.watch(baRepositoryProvider);
  final baDetail = await repository.getBaDetail(baId);
  return baDetail.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<String> createBa(Ref ref, CreateBaParams params) async {
  final repository = ref.watch(baRepositoryProvider);
  final result = await repository.createBa(params);
  return result.fold((l) => throw Exception(l), (r) => r);
}
