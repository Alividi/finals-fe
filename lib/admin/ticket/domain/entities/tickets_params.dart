class TicketsParams {
  final String? status;
  final String? keyword;

  TicketsParams({
    this.status,
    this.keyword,
  });
}

class TicketSummaryParams {
  final String? month;

  TicketSummaryParams({
    this.month,
  });
}

class CreateTicketParams {
  final int serviceId;
  final int gangguanId;

  CreateTicketParams({
    required this.serviceId,
    required this.gangguanId,
  });
}

class AssignTicketParams {
  final int ticketId;
  final int teknisiId;

  AssignTicketParams({
    required this.ticketId,
    required this.teknisiId,
  });
}
