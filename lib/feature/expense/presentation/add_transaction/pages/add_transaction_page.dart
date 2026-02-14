import 'package:go_router/go_router.dart';
import 'package:spend_wise/core/theme/app_colors.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_event.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_state.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/flow/add_transaction_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/sheets/amount_keypad_sheet.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/sheets/category_picker_sheet.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/sheets/type_selection_sheet.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/widgets/description_section.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/widgets/created_on_field.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/widgets/income_title_field.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/widgets/select_category_widget.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/widgets/transaction_header.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  bool _typeSheetShown = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<AddTransactionBloc>().add(FlowStarted());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleStep(context, AddTransactionStep.chooseType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTransactionBloc, AddTransactionState>(
      listenWhen: (previous, current) => previous.step != current.step,
      listener: (context, state) {
        _handleStep(context, state.step);
      },
      child: Scaffold(
        body: BlocBuilder<AddTransactionBloc, AddTransactionState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 22,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    // TRANSACTION TYPE HEADER
                    TransactionHeader(
                      type: state.type ?? TransactionType.expense,
                    ),
                    const SizedBox(height: 20),

                    /// AMOUNT
                    Text(
                      state.amount == 0
                          ? '0.00'
                          : state.amount.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 46,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const SelectCategory(),

                    /// CATEGORY
                    const SizedBox(height: 12),

                    IncomeTitleField(controller: _titleController),

                    const SizedBox(height: 12),

                    /// TITLE
                    CreatedOnRow(date: DateTime.now()),

                    const SizedBox(height: 12),

                    /// DESCRIPTION
                    DescriptionSection(controller: _descriptionController),

                    const Spacer(),

                    /// SUBMIT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<AddTransactionBloc>().add(
                              TransactionSubmitted(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          child: const Text(
                            'Add Entry',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleStep(BuildContext context, AddTransactionStep step) {
    switch (step) {
      case AddTransactionStep.chooseType:
        if (!_typeSheetShown) _typeSheetShown = true;
        showTypeSelectionSheet(
          context: context,
          onExpenseTap: () {
            Navigator.pop(context);
            context.read<AddTransactionBloc>().add(
              TransactionTypeSelected(TransactionType.expense),
            );
          },
          onIncomeTap: () {
            Navigator.pop(context);
            context.read<AddTransactionBloc>().add(
              TransactionTypeSelected(TransactionType.income),
            );
          },
        );

      case AddTransactionStep.enterAmount:
        showAmountSheet(
          context: context,
          onDigit: (d) {
            context.read<AddTransactionBloc>().add(AmountDigitPressed(d));
          },
          onBackspace: () {
            context.read<AddTransactionBloc>().add(AmountBackspacePressed());
          },
          onConfirm: () {
            Navigator.pop(context);
            context.read<AddTransactionBloc>().add(AmountConfirmation());
          },
        );
        break;

      case AddTransactionStep.selectCategory:
        showCategorySelectionSheet(context);
        break;

      case AddTransactionStep.addDetails:
        break;

      case AddTransactionStep.completed:
        context.go('/dashboard');
        break;
    }
  }
}
