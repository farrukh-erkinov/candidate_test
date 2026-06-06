import 'package:flutter/material.dart';

class NeonButton extends StatelessWidget {
  const NeonButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(30));

    return SizedBox(
      height: 56,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0x2400D1FF),
          borderRadius: borderRadius,
          border: Border.all(color: const Color(0xFF00D1FF), width: 3),
          boxShadow: const [
            BoxShadow(color: Color(0x8000D1FF), blurRadius: 24),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: borderRadius,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF00D1FF),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
