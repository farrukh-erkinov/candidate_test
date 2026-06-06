import 'package:flutter/material.dart';

import '../models/service_history_item.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final ServiceStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _statusColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        status.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 16 / 12,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Color get _statusColor {
    return switch (status) {
      ServiceStatus.inProgress => const Color(0xFFE9AC0D),
      ServiceStatus.rejected => const Color(0xFFF75045),
      ServiceStatus.completed => const Color(0xFF00C950),
    };
  }
}
