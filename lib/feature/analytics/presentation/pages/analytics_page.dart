import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/core/theme/app_colors.dart';
import 'package:spend_wise/feature/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:spend_wise/feature/analytics/presentation/bloc/analytics_event.dart';
import 'package:spend_wise/feature/analytics/presentation/bloc/analytics_state.dart';
import 'package:spend_wise/feature/analytics/presentation/widget/monthly_trend_chart.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/navigation/dashboard_nav_item.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/navigation/dashboard_nav_mapper.dart';
import 'package:spend_wise/feature/expense/presentation/widgets/dashboard_bottom_nav.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  void initState() {
    super.initState();
    context.read<AnalyticsBloc>().add(TrendRequested(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/dashboard');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Analytics'),
        backgroundColor: AppColors.background,
      ),
      body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == Status.error) {
            return const Center(child: Text('Failed to load analytics'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Center(
                  child: Text(
                    _calculateTotal(state),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                MonthlyTrendChart(trend: state.trend),

                const SizedBox(height: 30),

                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ListTile(
                        title: Text('Coffee'),
                        trailing: Text('-₹200'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: DashboardBottomNav(
        current: DashboardNavItem.home,
        onItemSelected: (item) {
          context.go(routeFromNavItem(item));
        },
      ),
    );
  }

  String _calculateTotal(AnalyticsState state) {
    final total = state.trend.fold<double>(0, (sum, e) => sum + e.totalAmount);

    return '₹${total.toStringAsFixed(2)}';
  }
}
