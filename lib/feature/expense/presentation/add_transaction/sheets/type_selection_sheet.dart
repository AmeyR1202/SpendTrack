import 'package:flutter/material.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/widgets/transaction_type_selector.dart';

Future<void> showTypeSelectionSheet({
  required BuildContext context,
  required VoidCallback onExpenseTap,
  required VoidCallback onIncomeTap,
}) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: TransactionTypeSelector(
          onExpenseTap: onExpenseTap,
          onIncomeTap: onIncomeTap,
        ),
      );
    },
  );
}
