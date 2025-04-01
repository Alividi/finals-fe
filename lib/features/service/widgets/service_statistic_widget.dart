import 'package:finals_fe/features/service/widgets/charm_widgets.dart';
import 'package:finals_fe/features/service/widgets/statistic_chart_service_widget.dart';
import 'package:finals_fe/utils/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceStatisticWidget extends StatelessWidget {
  const ServiceStatisticWidget({
    super.key,
    required this.selectedInterval,
  });

  final ValueNotifier<String> selectedInterval;

  @override
  Widget build(BuildContext context) {
    List<FlSpot> getDownlinkThroughputSpots(statistikData, getValue) {
      return List<FlSpot>.generate(
        10,
        (index) {
          final timestamp = index.toDouble();
          const value = 0;
          const maxValue = (value > 12) ? 12 : value;
          return FlSpot(timestamp, maxValue.toDouble());
        },
      );
    }

    List<FlSpot> getLatencySpots(statistikData, getValue) {
      return List<FlSpot>.generate(
        10,
        (index) {
          final timestamp = index.toDouble();
          const value = 0;
          const maxValue = (value > 200) ? 200 : value;
          return FlSpot(timestamp, maxValue.toDouble());
        },
      );
    }

    List<FlSpot> getSignalQualitySpots(statistikData, getValue) {
      return List<FlSpot>.generate(
        10,
        (index) {
          final timestamp = index.toDouble();
          const value = 0.0;
          return FlSpot(timestamp, value);
        },
      );
    }

    List<FlSpot> getUplinkThroughputSpots(statistikData, getValue) {
      return List<FlSpot>.generate(
        10,
        (index) {
          final timestamp = index.toDouble();
          const value = 0;
          const maxValue = (value > 3) ? 3 : value;
          return FlSpot(timestamp, maxValue.toDouble());
        },
      );
    }

    List<FlSpot> getPingDropRateSpots(statistikData, getValue) {
      return List<FlSpot>.generate(
        10,
        (index) {
          final timestamp = index.toDouble();
          const value = 0.0;
          return FlSpot(timestamp, value);
        },
      );
    }

    List<FlSpot> getObstructionSpots(statistikData, getValue) {
      return List<FlSpot>.generate(
        10,
        (index) {
          final timestamp = index.toDouble();
          const value = 0.0;
          return FlSpot(timestamp, value);
        },
      );
    }

    List<FlSpot> downlinkThroughputSpots =
        getDownlinkThroughputSpots('Downlink Throughput', (item) => (item ?? 0).toDouble());
    List<FlSpot> latencySpots = getLatencySpots('Latency', (item) => (item ?? 0).toDouble());
    List<FlSpot> signalQualitySpots =
        getSignalQualitySpots('Signal Quality', (item) => (item ?? 0).toDouble());
    List<FlSpot> uplinkThroughputSpots =
        getUplinkThroughputSpots('Uplink Throughput', (item) => (item ?? 0).toDouble());
    List<FlSpot> pingDropRateSpots =
        getPingDropRateSpots('Ping Drop Rate', (item) => (item ?? 0).toDouble());
    List<FlSpot> obstructionSpots =
        getObstructionSpots('Obstruction', (item) => (item ?? 0).toDouble());

    List<LineTooltipItem?> getTooltipItems(List<LineBarSpot> touchedSpots, String statistikData) {
      return touchedSpots.map((touchedSpots) {
        String statistik;
        switch (statistikData) {
          case 'Downlink Throughput':
            statistik = 'Downlink: 0 Mb/s';
            break;
          case 'Latency':
            statistik = 'Latency: 0 ms';
            break;
          case 'Signal Quality':
            statistik = 'Signal Quality: 0%';
            break;
          case 'Uplink Throughput':
            statistik = 'Uplink: 0Mb/s';
            break;
          case 'Ping Drop Rate':
            statistik = 'Ping Drop Rate: 0%';
            break;
          case 'Obstruction':
            statistik = 'Obstruction: 0%';
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
                fontWeight: FontWeight.w600));
      }).toList();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.area_chart_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
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
                )),
                child: DropdownButton(
                  value: selectedInterval.value,
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
                  items: <String>['15 Menit', '30 Menit', '1 Jam', '3 Jam', '12 Jam', '24 Jam']
                      .map<DropdownMenuItem<String>>((String value) {
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
              StatisticChartServiceWidget(
                spots: downlinkThroughputSpots,
                title: 'Downlink Throughput',
                bottomTitleText: bottomTitleText,
                leftTitleText: (value, meta) {
                  return leftTitleDownSpeedText(value, meta);
                },
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
                bottomTitleText: bottomTitleText,
                leftTitleText: (double value, TitleMeta meta) {
                  return leftTitleLatencyText(value, meta);
                },
                lineChartMinY: 0,
                lineChartMaxY: 200,
                leftTitleInterval: 5,
                getTooltipItems: (touchedSpots) => getTooltipItems(touchedSpots, 'Latency'),
              ),
              const Gap(16),
              StatisticChartServiceWidget(
                spots: signalQualitySpots,
                title: 'Signal Quality',
                bottomTitleText: bottomTitleText,
                leftTitleText: (double value, TitleMeta meta) {
                  return leftTitlePercentageText(value, meta);
                },
                lineChartMinY: 0,
                lineChartMaxY: 100,
                leftTitleInterval: 1,
                getTooltipItems: (touchedSpots) => getTooltipItems(touchedSpots, 'Signal Quality'),
              ),
              const Gap(16),
              StatisticChartServiceWidget(
                spots: uplinkThroughputSpots,
                title: 'Uplink Throughput',
                bottomTitleText: bottomTitleText,
                leftTitleText: (double value, TitleMeta meta) {
                  return leftTitleUpSpeedText(value, meta);
                },
                lineChartMinY: 0,
                lineChartMaxY: 3,
                leftTitleInterval: 1,
                getTooltipItems: (touchedSpots) =>
                    getTooltipItems(touchedSpots, 'Uplink Throughput'),
              ),
              const Gap(16),
              StatisticChartServiceWidget(
                spots: pingDropRateSpots,
                title: 'Ping Drop Rate',
                bottomTitleText: bottomTitleText,
                leftTitleText: (double value, TitleMeta meta) {
                  return leftTitlePercentageText(value, meta);
                },
                lineChartMinY: 0,
                lineChartMaxY: 100,
                leftTitleInterval: 1,
                getTooltipItems: (touchedSpots) => getTooltipItems(touchedSpots, 'Ping Drop Rate'),
              ),
              const Gap(16),
              StatisticChartServiceWidget(
                spots: obstructionSpots,
                title: 'Obstruction',
                bottomTitleText: bottomTitleText,
                leftTitleText: (double value, TitleMeta meta) {
                  return leftTitlePercentageText(value, meta);
                },
                lineChartMinY: 0,
                lineChartMaxY: 100,
                leftTitleInterval: 1,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
