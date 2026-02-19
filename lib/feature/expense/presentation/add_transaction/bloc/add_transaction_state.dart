import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/expense/domain/entities/category_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/flow/add_transaction_step.dart';

class AddTransactionState {
  final AddTransactionStep step;
  final TransactionType? type;
  final int amount;
  final String? categoryId;
  final List<CategoryEntity> categories;
  final String? notes;
  final Status status;

  const AddTransactionState({
    required this.step,
    this.type,
    this.amount = 0,
    this.categoryId,
    this.notes,
    this.status = Status.initial,
    this.categories = const [],
  });

  factory AddTransactionState.initial() {
    return const AddTransactionState(
      step: AddTransactionStep.chooseType,
      amount: 0,
    );
  }

  AddTransactionState copyWith({
    AddTransactionStep? step,
    TransactionType? type,
    int? amount,
    String? categoryId,
    List<CategoryEntity>? categories,
    String? notes,
    Status? status,
  }) {
    return AddTransactionState(
      step: step ?? this.step,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      categories: categories ?? this.categories,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }
}
