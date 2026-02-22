abstract class AnalyticsEvent {}

class AnalyticsRequested extends AnalyticsEvent {
  final DateTime month;

  AnalyticsRequested(this.month);
}

class TrendRequested extends AnalyticsEvent {
  final DateTime month;
  TrendRequested(this.month);
}
