import 'package:dartz/dartz.dart';
import 'package:finals_fe/admin/ba/domain/entities/ba_detail_model.dart';
import 'package:finals_fe/admin/ba/domain/entities/ba_params.dart';

abstract class BaRepository {
  Future<Either<String, BaDetailModel>> getBaDetail(int baId);
  Future<Either<String, String>> createBa(CreateBaParams params);
}
