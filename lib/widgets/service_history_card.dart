import 'package:flutter/material.dart';

import '../models/service_history_item.dart';
import 'glass_container.dart';
import 'neon_button.dart';
import 'service_category_row.dart';
import 'status_badge.dart';

class ServiceHistoryCard extends StatelessWidget {
  const ServiceHistoryCard({
    super.key,
    required this.item,
    this.isExpanded = false,
    this.onToggleExpanded,
  });

  final ServiceHistoryItem item;
  final bool isExpanded;
  final VoidCallback? onToggleExpanded;

  @override
  Widget build(BuildContext context) {
    final card = GlassContainer(
      width: double.infinity,
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusBadge(status: item.status),
          const SizedBox(height: 12),
          if (!item.compact) ...[
            _ProviderRow(item: item),
            const SizedBox(height: 12),
            const _CardDivider(),
            const SizedBox(height: 12),
          ],
          _MetricRow(item: item),
          const SizedBox(height: 12),
          const _CardDivider(),
          const SizedBox(height: 12),
          ServiceCategoryRow(
            category: item.category,
            categoryKey: item.categoryKey,
            showChevron: item.showChevron,
            isExpanded: isExpanded,
            onTap: onToggleExpanded,
          ),
          if (isExpanded)
            _ExpandedDetails(item: item)
          else ...[
            const SizedBox(height: 12),
            const _CardDivider(),
          ],
          const SizedBox(height: 12),
          _CostSection(cost: item.cost),
          if (isExpanded) const SizedBox(height: 22) else const Spacer(),
          NeonButton(label: 'Подробнее', onPressed: () {}),
        ],
      ),
    );

    if (isExpanded) {
      return SizedBox(width: double.infinity, child: card);
    }

    return SizedBox(
      height: item.compact ? 314 : 374,
      width: double.infinity,
      child: card,
    );
  }
}

class _ExpandedDetails extends StatelessWidget {
  const _ExpandedDetails({required this.item});

  final ServiceHistoryItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item.details.isNotEmpty) ...[
          const SizedBox(height: 8),
          for (final detail in item.details)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '– $detail',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                ),
              ),
            ),
        ],
        if (item.showCarPreview) ...[
          const SizedBox(height: 6),
          const Center(child: _CarPreview()),
        ],
        const SizedBox(height: 12),
        const _CardDivider(),
      ],
    );
  }
}

class _CarPreview extends StatelessWidget {
  const _CarPreview();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/car_preview.png',
      width: 214,
      height: 72,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
    );
  }
}

class _ProviderRow extends StatelessWidget {
  const _ProviderRow({required this.item});

  final ServiceHistoryItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        children: [
          ClipOval(
            child: item.providerLogoAsset == null
                ? const _LogoFallback()
                : Image.asset(
                    item.providerLogoAsset!,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const _LogoFallback();
                    },
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.providerName ?? '',
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
          if (item.rating != null) ...[
            const Icon(Icons.star_rounded, color: Color(0xFFFACC15), size: 18),
            const SizedBox(width: 4),
            Text(
              item.rating!.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.25,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LogoFallback extends StatelessWidget {
  const _LogoFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF1F2937), Color(0xFF00D1FF)],
        ),
      ),
      child: const Icon(Icons.car_repair, color: Colors.white, size: 18),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.item});

  final ServiceHistoryItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MetricPair(label: item.dateLabel, value: item.dateValue),
        ),
        const SizedBox(width: 17),
        Expanded(
          child: _MetricPair(label: 'Одометр (км)', value: item.odometer),
        ),
      ],
    );
  }
}

class _MetricPair extends StatelessWidget {
  const _MetricPair({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 16 / 12,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 18 / 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _CostSection extends StatelessWidget {
  const _CostSection({required this.cost});

  final String cost;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Общая стоимость по услугам (сум)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 16 / 12,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            cost,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardDivider extends StatelessWidget {
  const _CardDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: Color(0x12CFD8E5));
  }
}
