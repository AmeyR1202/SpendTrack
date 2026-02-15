import 'package:spend_wise/core/state/status.dart';

class OpeningBalanceState {
  final int amount;
  final Status status;

  const OpeningBalanceState({this.amount = 0, this.status = Status.initial});

  OpeningBalanceState copyWith({int? amount, Status? status}) {
    return OpeningBalanceState(
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }
}
