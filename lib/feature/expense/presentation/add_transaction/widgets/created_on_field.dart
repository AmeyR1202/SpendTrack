import 'package:flutter/material.dart';

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
        border: Border.all(color: Colors.grey, width: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              "Created on",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            Spacer(),
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
