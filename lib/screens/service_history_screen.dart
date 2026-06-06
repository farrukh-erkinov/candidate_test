import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/service_history_item.dart';
import '../widgets/glass_container.dart';
import '../widgets/license_plate.dart';
import '../widgets/search_filter_row.dart';
import '../widgets/service_history_card.dart';

class ServiceHistoryScreen extends StatelessWidget {
  const ServiceHistoryScreen({super.key});

  static const _backgroundAsset = 'assets/images/service_history_bg.png';
  static const _vakuumLogo = 'assets/images/vakuum_center.png';
  static const _masterproLogo = 'assets/images/masterpro.png';
  static const _propanLogo = 'assets/images/propan_quvvat.png';
  static const _bodyIcon = 'assets/icons/category_body.png';
  static const _chassisIcon = 'assets/icons/category_chassis.png';
  static const _fuelIcon = 'assets/icons/category_fuel.png';
  static const _propanIcon = 'assets/icons/category_propan.png';

  static const _items = <ServiceHistoryItem>[
    ServiceHistoryItem(
      providerName: 'Vakuum Center',
      providerLogoAsset: _vakuumLogo,
      rating: 4.8,
      status: ServiceStatus.inProgress,
      category: 'Кузов',
      categoryIconAsset: _bodyIcon,
      dateLabel: 'Дата начала',
      dateValue: '10.03.2026',
      odometer: '38 500',
      cost: '–',
      showChevron: true,
    ),
    ServiceHistoryItem(
      providerName: 'MasterPro',
      providerLogoAsset: _masterproLogo,
      rating: 4.8,
      status: ServiceStatus.rejected,
      category: 'Ходовая часть',
      categoryIconAsset: _chassisIcon,
      dateLabel: 'Дата отказа',
      dateValue: '20.03.2026',
      odometer: '40 300',
      cost: '–',
      showChevron: true,
    ),
    ServiceHistoryItem(
      status: ServiceStatus.completed,
      category: 'АЗС',
      categoryIconAsset: _fuelIcon,
      dateLabel: 'Дата конца',
      dateValue: '10.03.2026',
      odometer: '38 400',
      cost: '250 000',
      compact: true,
      showChevron: false,
    ),
    ServiceHistoryItem(
      providerName: 'Propan Quvvat',
      providerLogoAsset: _propanLogo,
      rating: 4.8,
      status: ServiceStatus.completed,
      category: 'АГЗС (пропан)',
      categoryIconAsset: _propanIcon,
      dateLabel: 'Дата конца',
      dateValue: '09.03.2026',
      odometer: '38 230',
      cost: '412 000',
      showChevron: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Color(0xFF040811),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(child: _ServiceHistoryBody()),
        ),
      ),
    );
  }
}

class _ServiceHistoryBody extends StatelessWidget {
  const _ServiceHistoryBody();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 68,
          left: -360,
          right: -360,
          height: 1921,
          child: _BackgroundTexture(),
        ),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 393),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _HeaderBar(),
                  const SizedBox(height: 16),
                  const _SegmentedHistoryTabs(),
                  const SizedBox(height: 24),
                  const Center(child: LicensePlate()),
                  const SizedBox(height: 24),
                  const _LastUpdatedRow(),
                  const SizedBox(height: 24),
                  const SearchFilterRow(),
                  const SizedBox(height: 16),
                  const _ServiceCountText(),
                  const SizedBox(height: 16),
                  for (
                    var index = 0;
                    index < ServiceHistoryScreen._items.length;
                    index++
                  ) ...[
                    ServiceHistoryCard(
                      item: ServiceHistoryScreen._items[index],
                    ),
                    if (index != ServiceHistoryScreen._items.length - 1)
                      const SizedBox(height: 16),
                  ],
                  const SizedBox(height: 24),
                  const Center(child: _LoadingIndicatorDots()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BackgroundTexture extends StatelessWidget {
  const _BackgroundTexture();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.08,
        child: Image.asset(
          ServiceHistoryScreen._backgroundAsset,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            top: 10,
            child: GlassContainer(
              width: 36,
              height: 36,
              borderRadius: BorderRadius.circular(100),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Center(
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Text(
            'Детали',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 24 / 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedHistoryTabs extends StatelessWidget {
  const _SegmentedHistoryTabs();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scale = (constraints.maxWidth / 353)
              .clamp(0.78, 1.0)
              .toDouble();
          final inactiveWidth = 153 * scale;
          final activeWidth = 215 * scale;
          final inactiveLeft = -27 * scale;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: inactiveLeft,
                top: 0,
                width: inactiveWidth,
                height: 42,
                child: GlassContainer(
                  borderRadius: BorderRadius.circular(16),
                  padding: EdgeInsets.symmetric(horizontal: 14 * scale),
                  child: const Center(
                    child: Text(
                      'Тех. состояние',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 18 / 14,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                width: activeWidth,
                height: 42,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 14 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00D1FF),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Color(0x9900D1FF), blurRadius: 60),
                    ],
                  ),
                  child: const Text(
                    'История обслуживаний',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF040811),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 18 / 14,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LastUpdatedRow extends StatelessWidget {
  const _LastUpdatedRow();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.refresh, color: Color(0xFF9CA3AF), size: 16),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              'Последнее обновление: 15.04.2026 16:44',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 20 / 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCountText extends StatelessWidget {
  const _ServiceCountText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
        ),
        children: [
          TextSpan(text: 'Всего сервисов: '),
          TextSpan(
            text: '720',
            style: TextStyle(
              color: Color(0xFF00D1FF),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingIndicatorDots extends StatelessWidget {
  const _LoadingIndicatorDots();

  @override
  Widget build(BuildContext context) {
    const alignments = [
      Alignment(0, -1),
      Alignment(0.7, -0.7),
      Alignment(1, 0),
      Alignment(0.7, 0.7),
      Alignment(0, 1),
      Alignment(-0.7, 0.7),
      Alignment(-1, 0),
      Alignment(-0.7, -0.7),
    ];

    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        children: [
          for (var index = 0; index < alignments.length; index++)
            Align(
              alignment: alignments[index],
              child: Container(
                width: index == 0 ? 7 : 6,
                height: index == 0 ? 7 : 6,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF00D1FF,
                  ).withValues(alpha: 0.25 + (index * 0.09)),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
