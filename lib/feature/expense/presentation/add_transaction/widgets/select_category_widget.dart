import 'package:flutter/material.dart';
import 'package:spend_wise/core/theme/app_colors.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: AppColors.background,
        backgroundColor: AppColors.background,

        foregroundColor: AppColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border, width: 0.2),
        ),
      ),
      onPressed: () {},

      child: const Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(Icons.add, size: 24, color: AppColors.background),
          SizedBox(width: 5),
          Text(
            'Select Category',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.background,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
