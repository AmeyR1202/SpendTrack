import 'package:spend_wise/feature/expense/domain/entities/category_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';

abstract class AddTransactionEvent {}

/// Flow lifecycle
class FlowStarted extends AddTransactionEvent {}

/// Step 1: type selection
class TransactionTypeSelected extends AddTransactionEvent {
  final TransactionType type;

  TransactionTypeSelected(this.type);
}

/// Step 2: amount entry
class AmountDigitPressed extends AddTransactionEvent {
  final int digit;

  AmountDigitPressed(this.digit);
}

class AmountConfirmation extends AddTransactionEvent {}

/// Step 3: category selection
class CategorySelected extends AddTransactionEvent {
  final CategoryEntity category;

  CategorySelected(this.category);
}

/// Step 4: notes
class NotesEntered extends AddTransactionEvent {
  final String notes;

  NotesEntered(this.notes);
}

/// Final submit
class TransactionSubmitted extends AddTransactionEvent {}

class AmountBackspacePressed extends AddTransactionEvent {}
