abstract class OpeningBalanceEvent {}

class DigitPressed extends OpeningBalanceEvent {
  final int digit;
  DigitPressed(this.digit);
}

class BackspacePressed extends OpeningBalanceEvent {}

class Submitted extends OpeningBalanceEvent {}
