import 'package:flutter/material.dart';

class ServiceCategoryRow extends StatelessWidget {
  const ServiceCategoryRow({
    super.key,
    required this.category,
    required this.categoryIconAsset,
    this.showChevron = true,
    this.isExpanded = false,
    this.onTap,
  });

  final String category;
  final String categoryIconAsset;
  final bool showChevron;
  final bool isExpanded;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final visual = _CategoryVisual.fromAsset(categoryIconAsset);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: showChevron ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: visual.color,
                  shape: BoxShape.circle,
                ),
                child: Icon(visual.icon, color: Colors.white, size: 13),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                  ),
                ),
              ),
              if (showChevron)
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryVisual {
  const _CategoryVisual({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  static _CategoryVisual fromAsset(String assetPath) {
    if (assetPath.contains('body')) {
      return const _CategoryVisual(color: Color(0xFFF97316), icon: Icons.build);
    }
    if (assetPath.contains('fuel')) {
      return const _CategoryVisual(
        color: Color(0xFFF59E0B),
        icon: Icons.local_gas_station,
      );
    }
    if (assetPath.contains('propan')) {
      return const _CategoryVisual(
        color: Color(0xFFA42DA2),
        icon: Icons.local_fire_department,
      );
    }
    return const _CategoryVisual(
      color: Color(0xFF06B6D4),
      icon: Icons.directions_car,
    );
  }
}
