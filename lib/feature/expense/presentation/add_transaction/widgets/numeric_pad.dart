import 'package:flutter/material.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/widgets/circle_button.dart';

class NumericPad extends StatelessWidget {
  final ValueChanged<int> onDigit;
  final VoidCallback onBackspace;
  final VoidCallback onConfirm;

  const NumericPad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget key(String text, {VoidCallback? onTap}) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.center,
            child: CircleButton(
              size: 70,
              onTap: onTap,
              child: text == '⌫'
                  ? const Icon(Icons.backspace_outlined, color: Colors.red)
                  : Text(
                      text,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            key('1', onTap: () => onDigit(1)),
            key('2', onTap: () => onDigit(2)),
            key('3', onTap: () => onDigit(3)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            key('4', onTap: () => onDigit(4)),
            key('5', onTap: () => onDigit(5)),
            key('6', onTap: () => onDigit(6)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            key('7', onTap: () => onDigit(7)),
            key('8', onTap: () => onDigit(8)),
            key('9', onTap: () => onDigit(9)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            key('.', onTap: () {}),
            key('0', onTap: () => onDigit(0)),
            key('⌫', onTap: onBackspace),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
