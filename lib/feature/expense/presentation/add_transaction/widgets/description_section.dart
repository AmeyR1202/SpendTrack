import 'package:flutter/material.dart';
import 'package:spend_wise/core/theme/app_colors.dart';

class DescriptionSection extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const DescriptionSection({
    super.key,
    required this.controller,
    this.hint = "Description",
  });

  @override
  Widget build(BuildContext context) {
    final hintColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 120),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ab",
                style: TextStyle(color: hintColor, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(color: hintColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
