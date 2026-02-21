import 'package:flutter/material.dart';
import 'package:spend_wise/core/theme/app_colors.dart';

class IncomeTitleField extends StatelessWidget {
  final TextEditingController controller;

  const IncomeTitleField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Income Title",
        prefixIcon: const Padding(
          padding: EdgeInsets.all(12),
          child: Text("AB", style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
