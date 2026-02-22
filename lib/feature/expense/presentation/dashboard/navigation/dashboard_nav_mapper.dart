import 'dashboard_nav_item.dart';

String routeFromNavItem(DashboardNavItem item) {
  switch (item) {
    case DashboardNavItem.home:
      return '/dashboard';
    case DashboardNavItem.add:
      return '/add-transaction';
    case DashboardNavItem.settings:
      return '/settings';
    case DashboardNavItem.analytics:
      return '/analytics';
  }
}
