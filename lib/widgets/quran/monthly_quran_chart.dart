import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class QuranMonthlyChart extends StatelessWidget {
  final List<int> weeklyPages = [5, 8, 3, 10];
  final List<String> weekLabels = ['الأول', 'الثاني', 'الثالث', 'الرابع'];

  QuranMonthlyChart({super.key});

  @override
  Widget build(BuildContext context) {
    final maxY = weeklyPages.reduce((a, b) => a > b ? a : b).toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Stack(
        alignment: Alignment.bottomCenter, // 👈 important!
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1.6,
                child: BarChart(
                  BarChartData(
                    maxY: maxY + 2,
                    barGroups: List.generate(weeklyPages.length, (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: weeklyPages[index].toDouble(),
                            color: Colors.teal,
                            width: 22,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ],
                        showingTooltipIndicators: [],
                      );
                    }),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 52,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${weeklyPages[index]} صفحات',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  weekLabels[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barTouchData: const BarTouchData(enabled: false),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 500),
                  swapAnimationCurve: Curves.easeInOut,
                ),
              ),
              const SizedBox(height: 32), // 👈 leave space for the label
            ],
          ),
          const Positioned(
            bottom: 0, // 👈 fixed position at the bottom
            child: Text(
              'الأسبوع',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
