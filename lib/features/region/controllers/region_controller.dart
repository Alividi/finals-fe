import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:finals_fe/features/region/data/region_repository_impl.dart';
import 'package:finals_fe/features/region/domain/entities/district_model.dart';
import 'package:finals_fe/features/region/domain/entities/province_model.dart';
import 'package:finals_fe/features/region/domain/entities/regency_model.dart';
import 'package:finals_fe/features/region/domain/entities/ward_model.dart';

part 'region_controller.g.dart';

@riverpod
Future<List<ProvinceModel>> getProvinces(GetProvincesRef ref) async {
  final repository = ref.watch(regionRepositoryProvider);

  final provinces = await repository.getProvinces();
  return provinces;
}

@riverpod
Future<List<RegencyModel>> getRegencies(GetRegenciesRef ref, {required String provinceId}) async {
  final repository = ref.watch(regionRepositoryProvider);

  final regencies = await repository.getRegencies(provinceId);
  return regencies;
}

@riverpod
Future<List<DistrictModel>> getDistricts(GetDistrictsRef ref, {required String regencyId}) async {
  final repository = ref.watch(regionRepositoryProvider);

  final districts = await repository.getDistricts(regencyId);
  return districts;
}

@riverpod
Future<List<WardModel>> getWards(GetWardsRef ref, {required String districtId}) async {
  final repository = ref.watch(regionRepositoryProvider);

  final wards = await repository.getWards(districtId);
  return wards;
}
