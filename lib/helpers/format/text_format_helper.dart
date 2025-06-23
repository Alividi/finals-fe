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

final statusMap = {
  'Masuk': 'open',
  'Proses': 'in_progress',
  'Selesai': 'closed',
  'Semua': null,
};

final List<String> monthsList = [
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
  'Desember',
];

final monthsMap = {
  'Januari': '1',
  'Februari': '2',
  'Maret': '3',
  'April': '4',
  'Mei': '5',
  'Juni': '6',
  'Juli': '7',
  'Agustus': '8',
  'September': '9',
  'Oktober': '10',
  'November': '11',
  'Desember': '12',
};

String getTicketStatusColor(String? status) {
  const statusName = {
    'open': 'Masuk',
    'in_progress': 'Proses',
    'closed': 'Selesai',
  };
  return statusName[status] ?? 'Masuk';
}
