import 'package:finals_fe/features/service/controllers/service_controllers.dart';
import 'package:finals_fe/features/service/domain/entities/services_params.dart';
import 'package:finals_fe/features/service/domain/entities/telemetry_model.dart';
import 'package:finals_fe/features/service/widgets/charm_widgets.dart';
import 'package:finals_fe/features/service/widgets/statistic_chart_service_widget.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceStatisticWidget extends ConsumerWidget {
  const ServiceStatisticWidget({
    super.key,
    required this.selectedInterval,
    required this.serviceId,
  });

  final ValueNotifier<String> selectedInterval;
  final int serviceId;

  int intervalToMinutes(String interval) {
    switch (interval) {
      case '15 Menit':
        return 15;
      case '30 Menit':
        return 30;
      case '1 Jam':
        return 60;
      case '3 Jam':
        return 180;
      case '12 Jam':
        return 720;
      case '24 Jam':
        return 1440;
      default:
        return 15;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intervalValue = selectedInterval.value;
    final interval = intervalToMinutes(intervalValue);

    final telemetryAsync = ref.watch(
      getServiceTelemetryProvider(
        TelemetryParams(serviceId: serviceId, interval: interval),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(24),
        Row(
          children: [
            const Icon(Icons.area_chart_rounded, size: 20, color: Colors.white),
            const Gap(10),
            Text(
              'Statistik Jaringan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: GoogleFonts.montserrat().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColor.blueBackground),
              borderRadius: BorderRadius.circular(9.5),
            ),
          ),
          child: DropdownButton<String>(
            value: intervalValue,
            isDense: true,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
            iconSize: 24,
            elevation: 16,
            dropdownColor: const Color(0xFF242134),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontWeight: FontWeight.w500,
            ),
            underline: Container(),
            items: <String>[
              '15 Menit',
              '30 Menit',
              '1 Jam',
              '3 Jam',
              '12 Jam',
              '24 Jam',
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              if (newValue != null) {
                selectedInterval.value = newValue;
              }
            },
          ),
        ),
        const Gap(24),
        Expanded(
          child: telemetryAsync.when(
            loading: () => const SizedBox(
              width: double.infinity,
              child: Text(
                'Loading...',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            error: (err, _) => Center(
              child: Text('Error: $err', style: const TextStyle(color: Colors.white)),
            ),
            data: (telemetryList) {
              List<FlSpot> buildSpots(
                  List<TelemetryModel> data, double? Function(TelemetryModel) getValue) {
                return data.asMap().entries.map((entry) {
                  final index = entry.key.toDouble();
                  final value = getValue(entry.value) ?? 0;
                  return FlSpot(index, value);
                }).toList();
              }

              Widget Function(double, TitleMeta) bottomTitleText(
                  List<TelemetryModel> telemetryList) {
                return (double value, TitleMeta meta) {
                  if (value.toInt() < telemetryList.length) {
                    final tsString = telemetryList[value.toInt()].ts.toString();
                    DateTime? tsLocal;

                    if (tsString != '') {
                      final utc = DateTime.parse(tsString.replaceFirst('Z', ''));
                      tsLocal = utc.toLocal();
                    }

                    final formatted = tsLocal != null
                        ? '${tsLocal.hour}:${tsLocal.minute.toString().padLeft(2, '0')}'
                        : '';

                    return Transform.rotate(
                      angle: -0.8,
                      child: Text(
                        formatted,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                };
              }

              final downlinkSpots =
                  buildSpots(telemetryList, (item) => item.downlinkTroughput?.clamp(0, 12));
              final uplinkSpots =
                  buildSpots(telemetryList, (item) => item.uplinkTroughput?.clamp(0, 3));
              final latencySpots =
                  buildSpots(telemetryList, (item) => item.pingLatencyMsAvg?.clamp(0, 200));
              final signalQualitySpots =
                  buildSpots(telemetryList, (item) => item.signalQuality?.clamp(0, 100));
              final pingDropSpots =
                  buildSpots(telemetryList, (item) => item.pingDropRateAvg?.clamp(0, 100));
              final obstructionSpots =
                  buildSpots(telemetryList, (item) => item.obstructionPercentTime?.clamp(0, 100));

              List<LineTooltipItem?> getTooltipItems(
                  List<LineBarSpot> touchedSpots, String statistikData) {
                return touchedSpots.map((touchedSpot) {
                  String statistik;
                  switch (statistikData) {
                    case 'Downlink Throughput':
                      statistik = 'Downlink: ${touchedSpot.y.toStringAsFixed(2)} Mb/s';
                      break;
                    case 'Latency':
                      statistik = 'Latency: ${touchedSpot.y.toStringAsFixed(0)} ms';
                      break;
                    case 'Signal Quality':
                      statistik = 'Signal Quality: ${touchedSpot.y.toStringAsFixed(0)}%';
                      break;
                    case 'Uplink Throughput':
                      statistik = 'Uplink: ${touchedSpot.y.toStringAsFixed(2)} Mb/s';
                      break;
                    case 'Ping Drop Rate':
                      statistik = 'Ping Drop Rate: ${touchedSpot.y.toStringAsFixed(0)}%';
                      break;
                    case 'Obstruction':
                      statistik = 'Obstruction: ${touchedSpot.y.toStringAsFixed(0)}%';
                      break;
                    default:
                      statistik = 'No data available';
                  }
                  return LineTooltipItem(
                    statistik,
                    TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }).toList();
              }

              return Column(
                children: [
                  StatisticChartServiceWidget(
                    spots: downlinkSpots,
                    title: 'Downlink Throughput',
                    bottomTitleText: bottomTitleText(telemetryList),
                    leftTitleText: leftTitleDownSpeedText,
                    lineChartMinY: 0,
                    lineChartMaxY: 12,
                    leftTitleInterval: 3,
                    getTooltipItems: (touchedSpots) =>
                        getTooltipItems(touchedSpots, 'Downlink Throughput'),
                  ),
                  const Gap(16),
                  StatisticChartServiceWidget(
                    spots: latencySpots,
                    title: 'Latency',
                    bottomTitleText: bottomTitleText(telemetryList),
                    leftTitleText: leftTitleLatencyText,
                    lineChartMinY: 0,
                    lineChartMaxY: 200,
                    leftTitleInterval: 50,
                    getTooltipItems: (touchedSpots) => getTooltipItems(touchedSpots, 'Latency'),
                  ),
                  const Gap(16),
                  StatisticChartServiceWidget(
                    spots: signalQualitySpots,
                    title: 'Signal Quality',
                    bottomTitleText: bottomTitleText(telemetryList),
                    leftTitleText: leftTitlePercentageText,
                    lineChartMinY: 0,
                    lineChartMaxY: 100,
                    leftTitleInterval: 25,
                    getTooltipItems: (touchedSpots) =>
                        getTooltipItems(touchedSpots, 'Signal Quality'),
                  ),
                  const Gap(16),
                  StatisticChartServiceWidget(
                    spots: uplinkSpots,
                    title: 'Uplink Throughput',
                    bottomTitleText: bottomTitleText(telemetryList),
                    leftTitleText: leftTitleUpSpeedText,
                    lineChartMinY: 0,
                    lineChartMaxY: 3,
                    leftTitleInterval: 1,
                    getTooltipItems: (touchedSpots) =>
                        getTooltipItems(touchedSpots, 'Uplink Throughput'),
                  ),
                  const Gap(16),
                  StatisticChartServiceWidget(
                    spots: pingDropSpots,
                    title: 'Ping Drop Rate',
                    bottomTitleText: bottomTitleText(telemetryList),
                    leftTitleText: leftTitlePercentageText,
                    lineChartMinY: 0,
                    lineChartMaxY: 100,
                    leftTitleInterval: 25,
                    getTooltipItems: (touchedSpots) =>
                        getTooltipItems(touchedSpots, 'Ping Drop Rate'),
                  ),
                  const Gap(16),
                  StatisticChartServiceWidget(
                    spots: obstructionSpots,
                    title: 'Obstruction',
                    bottomTitleText: bottomTitleText(telemetryList),
                    leftTitleText: leftTitlePercentageText,
                    lineChartMinY: 0,
                    lineChartMaxY: 100,
                    leftTitleInterval: 25,
                    getTooltipItems: (touchedSpots) => getTooltipItems(touchedSpots, 'Obstruction'),
                  ),
                  const Gap(16),
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Berhenti Berlangganan',
                        style: TextStyle(
                          color: const Color(0xFF7C7C7C),
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xFF7C7C7C),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
