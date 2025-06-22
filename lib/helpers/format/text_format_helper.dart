String formatTime(DateTime? dateTime) {
  if (dateTime == null) return '-';
  final diff = DateTime.now().difference(dateTime);

  if (diff.inMinutes < 60) {
    return '${diff.inMinutes} menit yang lalu';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} jam yang lalu';
  } else {
    return '${diff.inDays} hari yang lalu';
  }
}
