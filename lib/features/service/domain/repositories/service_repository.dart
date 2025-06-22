import 'package:dartz/dartz.dart';
import 'package:finals_fe/features/service/domain/entities/service_detail_model.dart';
import 'package:finals_fe/features/service/domain/entities/services_model.dart';
import 'package:finals_fe/features/service/domain/entities/services_params.dart';
import 'package:finals_fe/features/service/domain/entities/telemetry_model.dart';
import 'package:finals_fe/features/service/domain/entities/troubleshoot_model.dart';

abstract class ServiceRepository {
  Future<Either<String, List<ServicesModel>>> getServices(ServicesParams params);
  Future<Either<String, ServiceDetailModel>> getServiceById(int serviceId);
  Future<Either<String, List<TelemetryModel>>> getServiceTelemetry(TelemetryParams params);
  Future<Either<String, TroubleshootModel>> getTroubleshoot(int gangguanId);
  Future<Either<String, String>> changeCoordinate(ChangeCoordinateParams params);
}
