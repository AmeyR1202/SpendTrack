import 'package:expense_tracker/core/state/status.dart';
import 'package:expense_tracker/feature/expense/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:expense_tracker/feature/expense/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:expense_tracker/feature/expense/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    context.read<DashboardBloc>().add(DashboardStarted(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == Status.error) {
            return Center(
              child: Text(state.errorMessage ?? 'Something went wrong'),
            );
          }

          if (state.status == Status.success && state.summary != null) {
            return _SummaryView(
              income: state.summary!.totalIncome,
              expense: state.summary!.totalExpense,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _SummaryView extends StatelessWidget {
  final double income;
  final double expense;

  const _SummaryView({required this.income, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Income: ₹$income',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Text(
            'Expense: ₹$expense',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
