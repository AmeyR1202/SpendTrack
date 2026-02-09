import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double size;

  const CircleButton({
    super.key,
    required this.child,
    this.onTap,
    this.size = 32, // default small size (20–25ish)
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: size,
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.grey, width: 0.2),
        ),

        child: child,
      ),
    );
  }
}
