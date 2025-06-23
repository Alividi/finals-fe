import 'package:finals_fe/admin/ticket/data/ticket_repository_impl.dart';
import 'package:finals_fe/admin/ticket/domain/entities/ticket_detail_model.dart';
import 'package:finals_fe/admin/ticket/domain/entities/ticket_summary_model.dart';
import 'package:finals_fe/admin/ticket/domain/entities/tickets_model.dart';
import 'package:finals_fe/admin/ticket/domain/entities/tickets_params.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ticket_controllers.g.dart';

@riverpod
Future<List<TicketsModel>> getTickets(Ref ref, TicketsParams params) async {
  final repository = ref.watch(ticketRepositoryProvider);
  final tickets = await repository.getTickets(params);
  return tickets.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<TicketDetailModel> getTicketDetail(Ref ref, int ticketId) async {
  final repository = ref.watch(ticketRepositoryProvider);
  final ticketDetail = await repository.getTicketDetail(ticketId);
  return ticketDetail.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<TicketSummaryModel> getTicketSummary(Ref ref, TicketSummaryParams params) async {
  final repository = ref.watch(ticketRepositoryProvider);
  final ticketSummary = await repository.getTicketSummary(params);
  return ticketSummary.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<String> createTicket(Ref ref, CreateTicketParams params) async {
  final repository = ref.watch(ticketRepositoryProvider);
  final createTicket = await repository.createTicket(params);
  return createTicket.fold((error) => throw Exception(error), (data) => data);
}

@riverpod
Future<String> assignTicket(Ref ref, AssignTicketParams params) async {
  final repository = ref.watch(ticketRepositoryProvider);
  ref.invalidate(getTicketsProvider);
  ref.invalidate(getTicketSummaryProvider);
  ref.invalidate(getTicketDetailProvider(params.ticketId));
  final assignTicket = await repository.assignTicket(params);
  return assignTicket.fold((error) => throw Exception(error), (data) => data);
}
