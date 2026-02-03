import 'package:expense_tracker/core/presentation/widgets/app_drawer.dart';
import 'package:expense_tracker/core/presentation/widgets/greeting_app_bar.dart';
import 'package:expense_tracker/core/state/status.dart';
import 'package:expense_tracker/feature/expense/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:expense_tracker/feature/expense/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:expense_tracker/feature/expense/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:expense_tracker/feature/expense/presentation/user/bloc/user_bloc.dart';
import 'package:expense_tracker/feature/expense/presentation/widgets/balance_card.dart';
import 'package:expense_tracker/feature/expense/presentation/widgets/transaction_section_header.dart';
import 'package:expense_tracker/feature/expense/presentation/widgets/transaction_stat_card.dart';
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
    final userName = context.select<UserBloc, String>(
      (bloc) => bloc.state.user?.name ?? '',
    );
    return Scaffold(
      appBar: GreetingAppBar(username: userName),
      endDrawer: const AppDrawer(),

      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state.status == Status.success && state.summary != null) {
            final income = state.summary!.totalIncome;
            final expense = state.summary!.totalExpense;

            final balance = income - expense;

            final progress = income == 0
                ? 0.0
                : (expense / income).clamp(0.0, 1.0);

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BalanceCard(balance: balance, progress: progress),

                  const SizedBox(height: 16),

                  const TransactionsHeader(),

                  const SizedBox(height: 16),

                  Row(
                    children: const [
                      TransactionStatCard(
                        label: 'Income',

                        percentage: 24, // dummy for now
                        color: Colors.green,
                        icon: Icons.trending_up,
                      ),
                      SizedBox(width: 12),
                      TransactionStatCard(
                        label: 'Expense',
                        percentage: -42, // dummy for now
                        color: Colors.orange,
                        icon: Icons.trending_down,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Text('Transaction List will come here'),

                  const SizedBox(height: 32),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
