class NotificationsParams {
  final int page;
  final int pageSize;
  final String? type;
  NotificationsParams({
    required this.page,
    required this.pageSize,
    this.type,
  });
}
