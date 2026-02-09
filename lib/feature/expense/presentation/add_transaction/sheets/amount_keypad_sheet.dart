import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_state.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/widgets/numeric_pad.dart';

Future<void> showAmountSheet({
  required BuildContext context,
  required ValueChanged<int> onDigit,
  required VoidCallback onBackspace,
  required VoidCallback onConfirm,
}) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      final theme = Theme.of(context);

      return BlocProvider.value(
        value: context.read<AddTransactionBloc>(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 Padded zone
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<AddTransactionBloc, AddTransactionState>(
                    builder: (context, state) {
                      final value = state.amount;
                      return Text(
                        value == 0 ? '0' : value.toString(),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  /// keypad (no button inside)
                  NumericPad(
                    onDigit: onDigit,
                    onBackspace: onBackspace,
                    onConfirm: onConfirm,
                  ),
                ],
              ),
            ),

            /// 🔹 Footer (no horizontal padding)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: onConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
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
          ],
        ),
      );
    },
  );
}
