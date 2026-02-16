abstract class DashboardEvent {
  const DashboardEvent();
}

class DashboardStarted extends DashboardEvent {
  final DateTime month;

  const DashboardStarted(this.month);
}

class TransactionDeleted extends DashboardEvent {
  final String id;

  TransactionDeleted(this.id);
}
