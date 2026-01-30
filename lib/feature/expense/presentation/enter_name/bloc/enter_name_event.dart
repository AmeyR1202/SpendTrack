abstract class EnterNameEvent {}

class NameChanged extends EnterNameEvent {
  final String name;

  NameChanged(this.name);
}

class SavePressed extends EnterNameEvent {}
