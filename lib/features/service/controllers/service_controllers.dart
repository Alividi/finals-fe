import 'package:finals_fe/features/service/data/service_repository_impl.dart';
import 'package:finals_fe/features/service/domain/entities/service_detail_model.dart';
import 'package:finals_fe/features/service/domain/entities/services_model.dart';
import 'package:finals_fe/features/service/domain/entities/services_params.dart';
import 'package:finals_fe/features/service/domain/entities/telemetry_model.dart';
import 'package:finals_fe/features/service/domain/entities/troubleshoot_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_controllers.g.dart';

@riverpod
Future<List<ServicesModel>> getServices(Ref ref, ServicesParams params) async {
  final repository = ref.watch(serviceRepositoryProvider);
  final services = await repository.getServices(params);
  return services.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<ServiceDetailModel> getServiceById(Ref ref, int serviceId) async {
  final repository = ref.watch(serviceRepositoryProvider);
  final service = await repository.getServiceById(serviceId);
  return service.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<List<TelemetryModel>> getServiceTelemetry(Ref ref, TelemetryParams params) async {
  final repository = ref.watch(serviceRepositoryProvider);
  final telemetry = await repository.getServiceTelemetry(params);
  return telemetry.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<String> changeCoordinate(Ref ref, ChangeCoordinateParams params) async {
  final repository = ref.watch(serviceRepositoryProvider);
  final response = await repository.changeCoordinate(params);
  ref.invalidate(getServiceByIdProvider(params.serviceId));
  return response.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<TroubleshootModel> getTroubleshoot(Ref ref, int gangguanId) async {
  final repository = ref.watch(serviceRepositoryProvider);
  final troubleshoot = await repository.getTroubleshoot(gangguanId);
  return troubleshoot.fold((error) => throw Exception(error), (data) => data);
}
