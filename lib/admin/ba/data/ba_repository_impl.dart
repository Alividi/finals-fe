import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finals_fe/admin/ba/domain/entities/ba_detail_model.dart';
import 'package:finals_fe/admin/ba/domain/entities/ba_params.dart';
import 'package:finals_fe/admin/ba/domain/repositories/ba_repository.dart';
import 'package:finals_fe/core/provider/dio_provider.dart';
import 'package:finals_fe/helpers/format/multipartfile_format_helper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ba_repository_impl.g.dart';

@riverpod
BaRepository baRepository(Ref ref) {
  final httpClient = ref.watch(dioProvider);
  return BaRepositoryImpl(httpClient: httpClient);
}

class BaRepositoryImpl implements BaRepository {
  final Dio httpClient;

  BaRepositoryImpl({required this.httpClient});

  @override
  Future<Either<String, BaDetailModel>> getBaDetail(int baId) async {
    try {
      final response = await httpClient.get(
        'ba/$baId',
      );

      if (response.statusCode == 200) {
        final baDetail = BaDetailModel.fromJson(response.data['data']);
        return Right(baDetail);
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to get BA detail');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, String>> createBa(CreateBaParams params) async {
    try {
      final formDataMap = {
        'ticket_id': params.ticketId,
        'detail_ba': params.detailBa,
        'gambar_perangkat': await fileToMultipart(params.gambarPerangkat),
        'gambar_speedtest': await fileToMultipart(params.gambarSpeedtest),
      };

      for (int i = 0; i < params.biayaLainnya.length; i++) {
        final biaya = params.biayaLainnya[i];
        formDataMap.addAll({
          'biaya_lainnya[$i][jenis_biaya]': biaya.jenisBiaya,
          'biaya_lainnya[$i][jumlah]': biaya.jumlah,
          'biaya_lainnya[$i][lampiran]': await fileToMultipart(biaya.lampiran),
        });
      }

      final formData = FormData.fromMap(formDataMap);

      final response = await httpClient.post(
        'ba',
        data: formData,
      );

      if (response.statusCode == 200) {
        return const Right('Success');
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to create BA');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }
}
