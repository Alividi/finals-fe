import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:finals_fe/core/provider/dio_provider.dart';
import 'package:finals_fe/features/region/domain/entities/district_model.dart';
import 'package:finals_fe/features/region/domain/entities/province_model.dart';
import 'package:finals_fe/features/region/domain/entities/regency_model.dart';
import 'package:finals_fe/features/region/domain/entities/ward_model.dart';
import 'package:finals_fe/features/region/domain/repository/region_repository.dart';

part 'region_repository_impl.g.dart';

@riverpod
RegionRepository regionRepository(RegionRepositoryRef ref) {
  final httpClient = ref.watch(dioProvider);
  return RegionRepositoryImpl(httpClient: httpClient);
}

class RegionRepositoryImpl implements RegionRepository {
  final Dio httpClient;

  RegionRepositoryImpl({required this.httpClient});

  @override
  Future<List<ProvinceModel>> getProvinces() async {
    try {
      final response = await httpClient.get(
        '/wilayah/provinsi',
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List).map((item) => ProvinceModel.fromJson(item)).toList();
      } else {
        throw Exception('Gagal Mengambil Data Provinsi');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }

  @override
  Future<List<RegencyModel>> getRegencies(String provinceId) async {
    try {
      final response = await httpClient.get(
        '/wilayah/kabupaten/$provinceId',
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List).map((item) => RegencyModel.fromJson(item)).toList();
      } else {
        throw Exception('Gagal Mengambil Data Kabupaten');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }

  @override
  Future<List<DistrictModel>> getDistricts(String regencyId) async {
    try {
      final response = await httpClient.get(
        '/wilayah/kecamatan/$regencyId',
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List).map((item) => DistrictModel.fromJson(item)).toList();
      } else {
        throw Exception('Gagal Mengambil Data Kecamatan');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }

  @override
  Future<List<WardModel>> getWards(String districtId) async {
    try {
      final response = await httpClient.get(
        '/wilayah/kelurahan/$districtId',
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List).map((item) => WardModel.fromJson(item)).toList();
      } else {
        throw Exception('Gagal Mengambil Data Kelurahan');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }
}
