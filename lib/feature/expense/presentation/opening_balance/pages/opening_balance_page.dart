import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/core/theme/app_colors.dart';
import 'package:spend_wise/feature/expense/presentation/opening_balance/bloc/opening_balance_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/opening_balance/bloc/opening_balance_event.dart';
import 'package:spend_wise/feature/expense/presentation/opening_balance/bloc/opening_balance_state.dart';
import 'package:spend_wise/feature/expense/presentation/widgets/numeric_pad.dart';

class OpeningBalancePage extends StatelessWidget {
  const OpeningBalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OpeningBalanceBloc, OpeningBalanceState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == Status.success) {
          context.go('/dashboard');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),

                const Text(
                  'Enter your starting balance',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 40),

                BlocBuilder<OpeningBalanceBloc, OpeningBalanceState>(
                  builder: (context, state) {
                    return Text(
                      state.amount == 0 ? '₹0' : '₹${state.amount.toString()}',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),

                const Spacer(),

                NumericPad(
                  onDigit: (d) =>
                      context.read<OpeningBalanceBloc>().add(DigitPressed(d)),
                  onBackspace: () => context.read<OpeningBalanceBloc>().add(
                    BackspacePressed(),
                  ),
                  onConfirm: () =>
                      context.read<OpeningBalanceBloc>().add(Submitted()),
                ),

                ElevatedButton(
                  onPressed: () {
                    context.read<OpeningBalanceBloc>().add(Submitted());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
