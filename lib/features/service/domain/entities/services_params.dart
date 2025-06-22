class ServicesParams {
  final int? active;

  ServicesParams({
    this.active,
  });
}

class TelemetryParams {
  final int serviceId;
  final int interval;

  TelemetryParams({
    required this.serviceId,
    required this.interval,
  });
}

class ChangeCoordinateParams {
  final int serviceId;
  final double latitude;
  final double longitude;

  ChangeCoordinateParams({
    required this.serviceId,
    required this.latitude,
    required this.longitude,
  });
}
