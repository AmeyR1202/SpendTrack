import 'package:expense_tracker/core/state/status.dart';

class EnterNameState {
  final Status status;
  final String name;
  final String? errorMessage;

  EnterNameState({required this.status, required this.name, this.errorMessage});

  factory EnterNameState.initial() {
    return EnterNameState(status: Status.initial, name: '');
  }

  EnterNameState copyWith({
    Status? status,
    String? name,
    String? errorMessage,
  }) {
    return EnterNameState(
      status: status ?? this.status,
      name: name ?? this.name,
      errorMessage: errorMessage,
    );
  }
}
