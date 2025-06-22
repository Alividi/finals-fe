import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:finals_fe/admin/ticket/domain/entities/ticket_detail_model.dart';
import 'package:finals_fe/admin/ticket/domain/entities/ticket_summary_model.dart';
import 'package:finals_fe/admin/ticket/domain/entities/tickets_model.dart';
import 'package:finals_fe/admin/ticket/domain/entities/tickets_params.dart';
import 'package:finals_fe/admin/ticket/domain/repositories/ticket_repository.dart';
import 'package:finals_fe/core/provider/dio_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ticket_repository_impl.g.dart';

@riverpod
TicketRepository ticketRepository(Ref ref) {
  final httpClient = ref.watch(dioProvider);
  return TicketRepositoryImpl(httpClient: httpClient);
}

class TicketRepositoryImpl implements TicketRepository {
  final Dio httpClient;

  TicketRepositoryImpl({required this.httpClient});

  @override
  Future<Either<String, List<TicketsModel>>> getTickets(TicketsParams params) async {
    try {
      final response = await httpClient.get(
        'tickets',
        queryParameters: {
          if (params.status != null) 'status': params.status,
          if (params.keyword != null) 'keyword': params.keyword,
        },
      );

      if (response.statusCode == 200) {
        final tickets =
            (response.data['data'] as List).map((ticket) => TicketsModel.fromJson(ticket)).toList();
        return Right(tickets);
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to get tickets');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, TicketDetailModel>> getTicketDetail(int ticketId) async {
    try {
      final response = await httpClient.get(
        'tickets/$ticketId',
      );

      if (response.statusCode == 200) {
        final ticketDetail = TicketDetailModel.fromJson(response.data['data']);
        return Right(ticketDetail);
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to get ticket detail');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, TicketSummaryModel>> getTicketSummary(TicketSummaryParams params) async {
    try {
      final response = await httpClient.get(
        'tickets/summary',
        queryParameters: {
          if (params.month != null) 'month': params.month,
        },
      );

      if (response.statusCode == 200) {
        final ticketSummary = TicketSummaryModel.fromJson(response.data['data']);
        return Right(ticketSummary);
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to get ticket summary');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, String>> createTicket(CreateTicketParams params) async {
    try {
      final response = await httpClient.post(
        'tickets',
        data: {
          'service_id': params.serviceId,
          'gangguan_id': params.gangguanId,
        },
      );

      if (response.statusCode == 200) {
        return const Right('Ticket created successfully');
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to create ticket');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, String>> assignTicket(AssignTicketParams params) async {
    try {
      final response = await httpClient.post(
        'tickets/assign',
        data: {
          'ticket_id': params.ticketId,
          'teknisi_id': params.teknisiId,
        },
      );

      if (response.statusCode == 200) {
        return const Right('Ticket assigned successfully');
      } else if (response.data?['message'] != null) {
        return Left(response.data['message']);
      } else {
        throw Exception('Failed to assign ticket');
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ?? e.message ?? 'An unexpected error occurred';
      return Left(errorMessage);
    }
  }
}
