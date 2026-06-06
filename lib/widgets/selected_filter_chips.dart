import 'package:flutter/material.dart';

import '../models/service_history_item.dart';
import 'glass_container.dart';

class SelectedFilterChips extends StatelessWidget {
  const SelectedFilterChips({
    super.key,
    required this.filter,
    required this.onRemoveCategory,
    required this.onRemoveStatus,
    required this.onRemovePeriod,
  });

  final ServiceHistoryFilter filter;
  final ValueChanged<String> onRemoveCategory;
  final VoidCallback onRemoveStatus;
  final VoidCallback onRemovePeriod;

  @override
  Widget build(BuildContext context) {
    if (!filter.hasActiveFilters) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final category in filter.categories)
          _FilterChip(
            label: category,
            icon: Icons.local_gas_station,
            onRemove: () => onRemoveCategory(category),
          ),
        if (filter.status != null)
          _FilterChip(label: filter.status!.label, onRemove: onRemoveStatus),
        if (filter.period != ServicePeriod.all)
          _FilterChip(label: filter.period.label, onRemove: onRemovePeriod),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.onRemove, this.icon});

  final String label;
  final VoidCallback onRemove;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 14),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFFCFD8E5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Color(0xFF040811),
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
