import 'package:flutter/material.dart';
import 'package:spend_wise/core/theme/app_colors.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double progress; // 0.0 → 1.0

  const BalanceCard({super.key, required this.balance, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.background.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          _decorativeCircle(top: -40, right: -40),
          _decorativeCircle(bottom: -30, left: -30),

          // Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Balance',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const Icon(Icons.more_horiz, color: AppColors.textPrimary),
                ],
              ),

              const SizedBox(height: 20),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: AppColors.textSecondary,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.warning,
                    // yellow accent
                  ),
                ),
              ),

              const Spacer(),

              // Bottom row
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '**** **** 402',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 20,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: _CardDot(color: AppColors.error),
                        ),
                        Positioned(
                          left: 12,
                          child: _CardDot(color: AppColors.warning),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _decorativeCircle({
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.textPrimary.withValues(alpha: 0.05),
        ),
      ),
    );
  }
}

class _CardDot extends StatelessWidget {
  final Color color;

  const _CardDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      margin: const EdgeInsets.only(left: 6),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
