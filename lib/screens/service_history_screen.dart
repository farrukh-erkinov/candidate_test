import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/service_history_item.dart';
import '../screens/filters_screen.dart';
import '../widgets/empty_service_history_state.dart';
import '../widgets/glass_container.dart';
import '../widgets/license_plate.dart';
import '../widgets/search_filter_row.dart';
import '../widgets/selected_filter_chips.dart';
import '../widgets/service_history_card.dart';

class ServiceHistoryScreen extends StatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  static const _backgroundAsset = 'assets/images/service_history_bg.png';
  static const _vakuumLogo = 'assets/images/vakuum_center.png';
  static const _masterproLogo = 'assets/images/masterpro.png';
  static const _propanLogo = 'assets/images/propan_quvvat.png';
  static const _bodyKey = 'body';
  static const _chassisKey = 'chassis';
  static const _fuelKey = 'fuel';
  static const _propanKey = 'propan';

  static const _items = <ServiceHistoryItem>[
    ServiceHistoryItem(
      id: 'vakuum_center',
      providerName: 'Vakuum Center',
      providerLogoAsset: _vakuumLogo,
      rating: 4.8,
      status: ServiceStatus.inProgress,
      category: 'Кузов',
      categoryKey: _bodyKey,
      dateLabel: 'Дата начала',
      dateValue: '10.03.2026',
      odometer: '38 500',
      cost: '–',
      showChevron: true,
      isRecent: true,
      details: ['Локальная покраска'],
      showCarPreview: true,
    ),
    ServiceHistoryItem(
      id: 'masterpro',
      providerName: 'MasterPro',
      providerLogoAsset: _masterproLogo,
      rating: 4.8,
      status: ServiceStatus.rejected,
      category: 'Ходовая часть',
      categoryKey: _chassisKey,
      dateLabel: 'Дата отказа',
      dateValue: '20.03.2026',
      odometer: '40 300',
      cost: '–',
      showChevron: true,
      details: [
        'Замена масла двигателя',
        'Замена масляного фильтра',
        'Чистка форсунок (ультразвук/на стенде)',
      ],
    ),
    ServiceHistoryItem(
      id: 'azs_250',
      status: ServiceStatus.completed,
      category: 'АЗС',
      categoryKey: _fuelKey,
      dateLabel: 'Дата конца',
      dateValue: '10.03.2026',
      odometer: '38 400',
      cost: '250 000',
      compact: true,
      showChevron: false,
      isRecent: true,
    ),
    ServiceHistoryItem(
      id: 'propan_quvvat',
      providerName: 'Propan Quvvat',
      providerLogoAsset: _propanLogo,
      rating: 4.8,
      status: ServiceStatus.completed,
      category: 'АГЗС (пропан)',
      categoryKey: _propanKey,
      dateLabel: 'Дата конца',
      dateValue: '09.03.2026',
      odometer: '38 230',
      cost: '412 000',
      showChevron: false,
    ),
    ServiceHistoryItem(
      id: 'fath_oil',
      providerName: 'FathOil',
      rating: 4.8,
      status: ServiceStatus.completed,
      category: 'АЗС',
      categoryKey: _fuelKey,
      dateLabel: 'Дата конца',
      dateValue: '07.03.2026',
      odometer: '38 050',
      cost: '318 000',
      showChevron: false,
      showInDefault: false,
      isRecent: true,
    ),
    ServiceHistoryItem(
      id: 'azs_412',
      status: ServiceStatus.completed,
      category: 'АЗС',
      categoryKey: _fuelKey,
      dateLabel: 'Дата конца',
      dateValue: '04.03.2026',
      odometer: '37 290',
      cost: '412 000',
      compact: true,
      showChevron: false,
      showInDefault: false,
      isRecent: true,
    ),
  ];

  ServiceHistoryFilter _filter = const ServiceHistoryFilter();
  final Set<String> _expandedItemIds = {};

  @override
  Widget build(BuildContext context) {
    final items = _visibleItems;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF040811),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: _ServiceHistoryBody(
              filter: _filter,
              items: items,
              expandedItemIds: _expandedItemIds,
              onFilterTap: _openFilters,
              onRemoveCategory: _removeCategory,
              onRemoveStatus: _removeStatus,
              onRemovePeriod: _removePeriod,
              onToggleExpanded: _toggleExpanded,
            ),
          ),
        ),
      ),
    );
  }

  List<ServiceHistoryItem> get _visibleItems {
    if (!_filter.hasActiveFilters) {
      return _items.where((item) => item.showInDefault).toList();
    }

    return _items.where(_filter.matches).toList();
  }

  Future<void> _openFilters() async {
    final nextFilter = await Navigator.of(context).push<ServiceHistoryFilter>(
      MaterialPageRoute(
        builder: (context) => FiltersScreen(initialFilter: _filter),
      ),
    );

    if (nextFilter == null) {
      return;
    }

    setState(() {
      _filter = nextFilter;
      _expandedItemIds.clear();
    });
  }

  void _removeCategory(String category) {
    setState(() {
      _filter = _filter.removeCategory(category);
    });
  }

  void _removeStatus() {
    setState(() {
      _filter = _filter.removeStatus();
    });
  }

  void _removePeriod() {
    setState(() {
      _filter = _filter.removePeriod();
    });
  }

  void _toggleExpanded(String id) {
    setState(() {
      if (!_expandedItemIds.remove(id)) {
        _expandedItemIds.add(id);
      }
    });
  }
}

class _ServiceHistoryBody extends StatelessWidget {
  const _ServiceHistoryBody({
    required this.filter,
    required this.items,
    required this.expandedItemIds,
    required this.onFilterTap,
    required this.onRemoveCategory,
    required this.onRemoveStatus,
    required this.onRemovePeriod,
    required this.onToggleExpanded,
  });

  final ServiceHistoryFilter filter;
  final List<ServiceHistoryItem> items;
  final Set<String> expandedItemIds;
  final VoidCallback onFilterTap;
  final ValueChanged<String> onRemoveCategory;
  final VoidCallback onRemoveStatus;
  final VoidCallback onRemovePeriod;
  final ValueChanged<String> onToggleExpanded;

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
                  SearchFilterRow(
                    onFilterTap: onFilterTap,
                    activeFilterCount: filter.activeCount,
                  ),
                  if (filter.hasActiveFilters) ...[
                    const SizedBox(height: 10),
                    SelectedFilterChips(
                      filter: filter,
                      onRemoveCategory: onRemoveCategory,
                      onRemoveStatus: onRemoveStatus,
                      onRemovePeriod: onRemovePeriod,
                    ),
                    const SizedBox(height: 12),
                  ] else
                    const SizedBox(height: 16),
                  _ServiceCountText(
                    label: filter.hasActiveFilters
                        ? 'Найдено: '
                        : 'Всего сервисов: ',
                    count: filter.hasActiveFilters ? items.length : 720,
                  ),
                  const SizedBox(height: 16),
                  if (items.isEmpty)
                    const EmptyServiceHistoryState()
                  else ...[
                    for (var index = 0; index < items.length; index++) ...[
                      ServiceHistoryCard(
                        item: items[index],
                        isExpanded: expandedItemIds.contains(items[index].id),
                        onToggleExpanded: items[index].showChevron
                            ? () => onToggleExpanded(items[index].id)
                            : null,
                      ),
                      if (index != items.length - 1) const SizedBox(height: 16),
                    ],
                    const SizedBox(height: 24),
                    if (!filter.hasActiveFilters)
                      const Center(child: _LoadingIndicatorDots()),
                  ],
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
          _ServiceHistoryScreenState._backgroundAsset,
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
  const _ServiceCountText({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
        ),
        children: [
          TextSpan(text: label),
          TextSpan(
            text: '$count',
            style: const TextStyle(
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
