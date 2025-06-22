class ServicesParams {
  final int? active;

  ServicesParams({
    this.active,
  });
}

class TelemetryParams {
  final int serviceId;
  final int interval;

  const TelemetryParams({required this.serviceId, required this.interval});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TelemetryParams &&
          runtimeType == other.runtimeType &&
          serviceId == other.serviceId &&
          interval == other.interval;

  @override
  int get hashCode => serviceId.hashCode ^ interval.hashCode;
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
