import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finals_fe/core/provider/dio_provider.dart';
import 'package:finals_fe/features/service/domain/entities/service_detail_model.dart';
import 'package:finals_fe/features/service/domain/entities/services_model.dart';
import 'package:finals_fe/features/service/domain/entities/services_params.dart';
import 'package:finals_fe/features/service/domain/entities/telemetry_model.dart';
import 'package:finals_fe/features/service/domain/entities/troubleshoot_model.dart';
import 'package:finals_fe/features/service/domain/repositories/service_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_repository_impl.g.dart';

@riverpod
ServiceRepository serviceRepository(Ref ref) {
  final httpClient = ref.watch(dioProvider);
  return ServiceRepositoryImpl(
    httpClient: httpClient,
  );
}

class ServiceRepositoryImpl implements ServiceRepository {
  final Dio httpClient;

  ServiceRepositoryImpl({
    required this.httpClient,
  });

  @override
  Future<Either<String, List<ServicesModel>>> getServices(ServicesParams params) async {
    try {
      final response = await httpClient.get(
        'services',
        queryParameters: {
          if (params.active != null) 'active': params.active,
        },
      );

      if (response.statusCode == 200) {
        final services = (response.data['data'] as List)
            .map((service) => ServicesModel.fromJson(service))
            .toList();
        return Right(services);
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to get services');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, ServiceDetailModel>> getServiceById(int serviceId) async {
    try {
      final response = await httpClient.get(
        'services/$serviceId',
      );

      if (response.statusCode == 200) {
        final serviceDetail = ServiceDetailModel.fromJson(response.data['data']);
        return Right(serviceDetail);
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to get service detail');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, List<TelemetryModel>>> getServiceTelemetry(TelemetryParams params) async {
    try {
      final response = await httpClient.get(
        'services/${params.serviceId}/statistics',
        queryParameters: {
          'interval': params.interval,
        },
      );

      if (response.statusCode == 200) {
        final telemetry = (response.data['data'] as List)
            .map((telemetry) => TelemetryModel.fromJson(telemetry))
            .toList();
        return Right(telemetry);
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to get service telemetry');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, TroubleshootModel>> getTroubleshoot(int gangguanId) async {
    try {
      final response = await httpClient.get(
        'services/$gangguanId/troubleshoot',
      );

      if (response.statusCode == 200) {
        final troubleshoot = TroubleshootModel.fromJson(response.data['data']);
        return Right(troubleshoot);
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to get troubleshoot');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, String>> changeCoordinate(ChangeCoordinateParams params) async {
    try {
      final response = await httpClient.put(
        'services/change-coordinates',
        data: {
          'latitude': params.latitude,
          'longitude': params.longitude,
          'service_id': params.serviceId,
        },
      );

      if (response.statusCode == 200) {
        return const Right('Success');
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to change coordinate');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }
}
