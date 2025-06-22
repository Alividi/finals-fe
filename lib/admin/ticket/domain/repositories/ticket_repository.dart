import 'package:dartz/dartz.dart';
import 'package:finals_fe/admin/ticket/domain/entities/ticket_detail_model.dart';
import 'package:finals_fe/admin/ticket/domain/entities/ticket_summary_model.dart';
import 'package:finals_fe/admin/ticket/domain/entities/tickets_model.dart';
import 'package:finals_fe/admin/ticket/domain/entities/tickets_params.dart';

abstract class TicketRepository {
  Future<Either<String, List<TicketsModel>>> getTickets(TicketsParams params);
  Future<Either<String, TicketDetailModel>> getTicketDetail(int ticketId);
  Future<Either<String, TicketSummaryModel>> getTicketSummary(TicketSummaryParams params);
  Future<Either<String, String>> createTicket(CreateTicketParams params);
  Future<Either<String, String>> assignTicket(AssignTicketParams params);
}
