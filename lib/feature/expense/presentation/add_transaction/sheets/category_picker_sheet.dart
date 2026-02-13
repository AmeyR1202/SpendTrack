import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_wise/core/theme/app_colors.dart';
import 'package:spend_wise/feature/expense/domain/entities/category_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_event.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_state.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/widgets/category_chip.dart';

Future<void> showCategorySelectionSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return BlocProvider.value(
        value: context.read<AddTransactionBloc>(),
        child: const _CategorySelectionContent(),
      );
    },
  );
}

class _CategorySelectionContent extends StatelessWidget {
  const _CategorySelectionContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// later → load from DB and we'll create type (income/expense)
    /// and render only those chip widgets which are included in income or expense
    final categories = [
      CategoryEntity(
        categoryId: '1',
        categoryName: 'Fuel',
        type: TransactionType.expense,
      ),
      CategoryEntity(
        categoryId: '2',
        categoryName: 'Service',
        type: TransactionType.expense,
      ),
      CategoryEntity(
        categoryId: '3',
        categoryName: 'Maintenance',
        type: TransactionType.expense,
      ),
      CategoryEntity(
        categoryId: '4',
        categoryName: 'Repair',
        type: TransactionType.expense,
      ),

      // ✅ income
      CategoryEntity(
        categoryId: '5',
        categoryName: 'Salary',
        type: TransactionType.income,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Select Category', style: theme.textTheme.titleLarge),
          const SizedBox(height: 20),

          BlocBuilder<AddTransactionBloc, AddTransactionState>(
            builder: (context, state) {
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final cat in categories)
                    CategoryChip(
                      label: cat.categoryName,
                      icon: Icons.category,
                      selected: state.category?.categoryId == cat.categoryId,
                      onTap: () {
                        context.read<AddTransactionBloc>().add(
                          CategorySelected(cat),
                        );
                      },
                    ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
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
        ],
      ),
    );
  }
}
