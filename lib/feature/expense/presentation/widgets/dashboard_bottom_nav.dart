import 'package:spend_wise/core/theme/app_colors.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/navigation/dashboard_nav_item.dart';
import 'package:flutter/material.dart';

class DashboardBottomNav extends StatelessWidget {
  final DashboardNavItem current;
  final ValueChanged<DashboardNavItem> onItemSelected;

  const DashboardBottomNav({
    super.key,
    required this.current,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final active = Theme.of(context).colorScheme.primary;
    const inactive = AppColors.textSecondary;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: current == DashboardNavItem.home ? active : inactive,
              ),
              onPressed: () => onItemSelected(DashboardNavItem.home),
            ),

            const SizedBox(width: 48),

            IconButton(
              icon: Icon(
                Icons.settings,
                color: current == DashboardNavItem.settings ? active : inactive,
              ),
              onPressed: () => onItemSelected(DashboardNavItem.settings),
            ),
          ],
        ),
      ),
    );
  }
}
