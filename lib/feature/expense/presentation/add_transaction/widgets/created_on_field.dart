import 'package:flutter/material.dart';
import 'package:spend_wise/core/theme/app_colors.dart';

class CreatedOnRow extends StatelessWidget {
  final DateTime date;

  const CreatedOnRow({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final formatted =
        "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}   "
        "${TimeOfDay.fromDateTime(date).format(context)}";

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.textMuted,
              size: 20,
            ),
            const SizedBox(width: 12),
            const Text(
              "Created on",
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
            ),
            const Spacer(),
            Text(
              formatted,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
