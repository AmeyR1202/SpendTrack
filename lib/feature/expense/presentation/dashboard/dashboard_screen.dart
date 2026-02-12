import 'package:spend_wise/core/presentation/widgets/app_drawer.dart';
import 'package:spend_wise/core/presentation/widgets/greeting_app_bar.dart';
import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/navigation/dashboard_nav_item.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/navigation/dashboard_nav_mapper.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/widgets/transaction_list.dart';
import 'package:spend_wise/feature/expense/presentation/user/bloc/user_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/widgets/balance_card.dart';
import 'package:spend_wise/feature/expense/presentation/widgets/dashboard_bottom_nav.dart';
import 'package:spend_wise/feature/expense/presentation/widgets/transaction_section_header.dart';
import 'package:spend_wise/feature/expense/presentation/widgets/transaction_stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Text(
                        'Transactions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  Expanded(
                    child: TransactionList(transactions: state.transactions),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: DashboardBottomNav(
        current: DashboardNavItem.home,
        onItemSelected: (item) {
          context.go(routeFromNavItem(item));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(routeFromNavItem(DashboardNavItem.add));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
