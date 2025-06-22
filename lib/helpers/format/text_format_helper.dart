String formatTime(DateTime? dateTime) {
  if (dateTime == null) return '-';

  final localDateTime = dateTime.toLocal();
  final diff = DateTime.now().difference(localDateTime);

  if (diff.isNegative) return 'baru saja';

  if (diff.inMinutes < 60) {
    return '${diff.inMinutes} menit yang lalu';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} jam yang lalu';
  } else {
    return '${diff.inDays} hari yang lalu';
  }
}

String formatToIndonesianDate(String isoString) {
  final cleanedIso = isoString.endsWith('Z') ? isoString.replaceFirst('Z', '') : isoString;
  final dateTime = DateTime.parse(cleanedIso).toLocal();

  const monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  final day = dateTime.day;
  final month = monthNames[dateTime.month - 1];
  final year = dateTime.year;

  return '$day $month $year';
}
