import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spend_wise/core/theme/app_colors.dart';
import 'package:spend_wise/feature/analytics/domain/entities/daily_spending.dart';

class MonthlyTrendChart extends StatelessWidget {
  final List<DailySpending> trend;

  const MonthlyTrendChart({super.key, required this.trend});

  @override
  Widget build(BuildContext context) {
    if (trend.isEmpty) {
      return const Center(child: Text('No spending this month'));
    }

    final spots = trend
        .map((e) => FlSpot(e.date.day.toDouble(), e.totalAmount))
        .toList();

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: trend.last.date.day.toDouble(),
          minY: 0,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 1,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.background,
              ),
            ),
          ],
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
