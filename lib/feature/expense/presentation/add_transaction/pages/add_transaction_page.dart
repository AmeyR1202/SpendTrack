import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_event.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_state.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/flow/add_transaction_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/sheets/amount_keypad_sheet.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/sheets/type_selection_sheet.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  bool _typeSheetShown = false;

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
      child: const Scaffold(backgroundColor: Colors.white),
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
        // TODO: show category sheet
        break;

      case AddTransactionStep.addDetails:
        // TODO: show details sheet
        break;

      case AddTransactionStep.completed:
        Navigator.of(context).pop();
        break;
    }
  }
}
