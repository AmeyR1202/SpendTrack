abstract class AnalyticsEvent {}

class AnalyticsRequested extends AnalyticsEvent {
  final DateTime month;

  AnalyticsRequested(this.month);
}
