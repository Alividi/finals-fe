import 'package:finals_fe/features/region/domain/entities/district_model.dart';
import 'package:finals_fe/features/region/domain/entities/province_model.dart';
import 'package:finals_fe/features/region/domain/entities/regency_model.dart';
import 'package:finals_fe/features/region/domain/entities/ward_model.dart';

abstract class RegionRepository {
  Future<List<ProvinceModel>> getProvinces();
  Future<List<RegencyModel>> getRegencies(String provinceId);
  Future<List<DistrictModel>> getDistricts(String regencyId);
  Future<List<WardModel>> getWards(String districtId);
}
