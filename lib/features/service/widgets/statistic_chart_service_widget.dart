import 'package:finals_fe/utils/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticChartServiceWidget extends StatelessWidget {
  final List<FlSpot> spots;
  final String title;
  final Widget Function(double value, TitleMeta meta) bottomTitleText;
  final Widget Function(double value, TitleMeta meta) leftTitleText;
  final double lineChartMinY;
  final double lineChartMaxY;
  final double leftTitleInterval;
  final List<LineTooltipItem?> Function(List<LineBarSpot> touchedSpots) getTooltipItems;

  const StatisticChartServiceWidget({
    super.key,
    required this.spots,
    required this.title,
    required this.bottomTitleText,
    required this.leftTitleText,
    required this.lineChartMinY,
    required this.lineChartMaxY,
    required this.leftTitleInterval,
    required this.getTooltipItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontFamily: GoogleFonts.montserrat().fontFamily,
              color: AppColor.white,
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.blueBackground, width: 0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: AspectRatio(
              aspectRatio: 2,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      show: true,
                      spots: spots,
                      barWidth: 2,
                      color: AppColor.lightTeal,
                      belowBarData: BarAreaData(
                        show: true,
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (p0, p1, p2, p3) {
                          return FlDotCirclePainter(
                            radius: 3,
                            color: Colors.transparent,
                            strokeWidth: 1.5,
                            strokeColor: AppColor.lightTeal,
                          );
                        },
                      ),
                    ),
                  ],
                  gridData: const FlGridData(show: false),
                  lineTouchData: LineTouchData(
                      enabled: true,
                      getTouchedSpotIndicator: (barData, spotIndexes) {
                        return spotIndexes.map((index) {
                          return const TouchedSpotIndicatorData(
                              FlLine(color: Colors.blue, strokeWidth: 2), FlDotData(show: true));
                        }).toList();
                      },
                      touchTooltipData: LineTouchTooltipData(getTooltipItems: getTooltipItems)),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 65,
                          interval: leftTitleInterval,
                          getTitlesWidget: leftTitleText),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          interval: 1,
                          getTitlesWidget: bottomTitleText),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  minY: lineChartMinY,
                  maxY: lineChartMaxY,
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(
                        color: Colors.white,
                        width: 3,
                      ),
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 3,
                      ),
                      top: BorderSide.none,
                      right: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
