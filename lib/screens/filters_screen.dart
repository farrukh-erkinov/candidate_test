import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/service_history_item.dart';
import '../widgets/glass_container.dart';
import '../widgets/neon_button.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.initialFilter});

  final ServiceHistoryFilter initialFilter;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  static const _backgroundAsset = 'assets/images/service_history_bg.png';

  static const _categories = <_CategoryFilterOption>[
    _CategoryFilterOption('АЗС', Icons.local_gas_station, Color(0xFFF59E0B)),
    _CategoryFilterOption('АГНКС\n(метан)', Icons.propane, Color(0xFFC24141)),
    _CategoryFilterOption(
      'АГЗС\n(пропан)',
      Icons.local_fire_department,
      Color(0xFFC143B9),
    ),
    _CategoryFilterOption(
      'Электро-\nстанция',
      Icons.ev_station,
      Color(0xFF14D8CF),
    ),
    _CategoryFilterOption('Парковка', Icons.local_parking, Color(0xFF0891B2)),
    _CategoryFilterOption('Автомойка', Icons.local_car_wash, Color(0xFF0EA5E9)),
    _CategoryFilterOption('Замена\nмасла', Icons.oil_barrel, Color(0xFFB7791F)),
    _CategoryFilterOption('Двигатель', Icons.car_repair, Color(0xFFEF4444)),
    _CategoryFilterOption(
      'Диагнос-\nтика',
      Icons.monitor_heart,
      Color(0xFF8B5CF6),
    ),
    _CategoryFilterOption(
      'Шиномон-\nтаж',
      Icons.tire_repair,
      Color(0xFF10B981),
    ),
    _CategoryFilterOption(
      'Ходовая\nчасть',
      Icons.directions_car,
      Color(0xFF06B6D4),
    ),
    _CategoryFilterOption('Кузов', Icons.build, Color(0xFFF97316)),
    _CategoryFilterOption(
      'Электро и\nгибрид',
      Icons.battery_charging_full,
      Color(0xFF3B82F6),
    ),
    _CategoryFilterOption('Электрика', Icons.lightbulb, Color(0xFFEAB308)),
    _CategoryFilterOption(
      'Детейлинг',
      Icons.cleaning_services,
      Color(0xFFEC4899),
    ),
    _CategoryFilterOption('Тюнинг', Icons.speed, Color(0xFF6366F1)),
    _CategoryFilterOption('СТО', Icons.engineering, Color(0xFF94A3B8)),
  ];

  late ServiceHistoryFilter _filter;

  @override
  void initState() {
    super.initState();
    _filter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF040811),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              const Positioned(
                top: 74,
                left: -120,
                right: -120,
                bottom: 0,
                child: _FiltersBackground(),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 393),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _FiltersHeader(
                          hasFilters: _filter.hasActiveFilters,
                          onReset: _resetFilters,
                        ),
                        const SizedBox(height: 22),
                        const _SectionTitle('Категории'),
                        const SizedBox(height: 4),
                        const Text(
                          'Выберите одну или несколько категории',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _CategoryGrid(
                          categories: _categories,
                          selectedCategories: _filter.categories,
                          onToggle: _toggleCategory,
                        ),
                        const SizedBox(height: 30),
                        const _SectionTitle('Статус'),
                        const SizedBox(height: 14),
                        _StatusOptions(
                          selectedStatus: _filter.status,
                          onChanged: _setStatus,
                        ),
                        const SizedBox(height: 24),
                        const _SectionTitle('Период'),
                        const SizedBox(height: 14),
                        _PeriodOptions(
                          selectedPeriod: _filter.period,
                          onChanged: _setPeriod,
                        ),
                        const SizedBox(height: 26),
                        _ApplyButton(
                          enabled: _filter.hasActiveFilters,
                          onApply: () => Navigator.of(context).pop(_filter),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleCategory(String category) {
    final categories = {..._filter.categories};
    if (!categories.remove(category)) {
      categories.add(category);
    }
    setState(() {
      _filter = _filter.copyWith(categories: categories);
    });
  }

  void _setStatus(ServiceStatus? status) {
    setState(() {
      _filter = status == null
          ? _filter.copyWith(clearStatus: true)
          : _filter.copyWith(status: status);
    });
  }

  void _setPeriod(ServicePeriod period) {
    setState(() {
      _filter = _filter.copyWith(period: period);
    });
  }

  void _resetFilters() {
    setState(() {
      _filter = const ServiceHistoryFilter();
    });
  }
}

class _FiltersBackground extends StatelessWidget {
  const _FiltersBackground();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.1,
      child: Image.asset(
        _FiltersScreenState._backgroundAsset,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}

class _FiltersHeader extends StatelessWidget {
  const _FiltersHeader({required this.hasFilters, required this.onReset});

  final bool hasFilters;
  final VoidCallback onReset;

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
                  onTap: () => Navigator.of(context).pop(),
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
            'Фильтры',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 24 / 18,
            ),
          ),
          if (hasFilters)
            Positioned(
              right: 0,
              top: 17,
              child: GestureDetector(
                onTap: onReset,
                child: const Text(
                  'Сбросить',
                  style: TextStyle(
                    color: Color(0xFFFF4B45),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({
    required this.categories,
    required this.selectedCategories,
    required this.onToggle,
  });

  final List<_CategoryFilterOption> categories;
  final Set<String> selectedCategories;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 18,
      children: [
        for (final option in categories)
          _CategoryOptionTile(
            option: option,
            isSelected: selectedCategories.contains(option.labelPlain),
            onTap: () => onToggle(option.labelPlain),
          ),
      ],
    );
  }
}

class _CategoryOptionTile extends StatelessWidget {
  const _CategoryOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _CategoryFilterOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: option.color,
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? const [
                            BoxShadow(
                              color: Color(0x9900C950),
                              blurRadius: 24,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(option.icon, color: Colors.white, size: 17),
                ),
                if (isSelected)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00C950),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              option.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusOptions extends StatelessWidget {
  const _StatusOptions({required this.selectedStatus, required this.onChanged});

  final ServiceStatus? selectedStatus;
  final ValueChanged<ServiceStatus?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _SelectablePill(
            label: 'Все',
            isSelected: selectedStatus == null,
            onTap: () => onChanged(null),
          ),
          const SizedBox(width: 10),
          _SelectablePill(
            label: ServiceStatus.completed.label,
            isSelected: selectedStatus == ServiceStatus.completed,
            onTap: () => onChanged(ServiceStatus.completed),
          ),
          const SizedBox(width: 10),
          _SelectablePill(
            label: ServiceStatus.inProgress.label,
            isSelected: selectedStatus == ServiceStatus.inProgress,
            onTap: () => onChanged(ServiceStatus.inProgress),
          ),
        ],
      ),
    );
  }
}

class _PeriodOptions extends StatelessWidget {
  const _PeriodOptions({required this.selectedPeriod, required this.onChanged});

  final ServicePeriod selectedPeriod;
  final ValueChanged<ServicePeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _SelectablePill(
            label: ServicePeriod.all.label,
            isSelected: selectedPeriod == ServicePeriod.all,
            onTap: () => onChanged(ServicePeriod.all),
          ),
          const SizedBox(width: 10),
          _SelectablePill(
            label: ServicePeriod.last7.label,
            isSelected: selectedPeriod == ServicePeriod.last7,
            onTap: () => onChanged(ServicePeriod.last7),
          ),
        ],
      ),
    );
  }
}

class _SelectablePill extends StatelessWidget {
  const _SelectablePill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final child = Center(
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF040811) : Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: isSelected
          ? Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF00D1FF),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Color(0x8000D1FF), blurRadius: 24),
                ],
              ),
              child: child,
            )
          : GlassContainer(
              height: 36,
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: child,
            ),
    );
  }
}

class _ApplyButton extends StatelessWidget {
  const _ApplyButton({required this.enabled, required this.onApply});

  final bool enabled;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    if (enabled) {
      return NeonButton(label: 'Применить', onPressed: onApply);
    }

    return SizedBox(
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0x1400D1FF),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0x9900D1FF), width: 2),
        ),
        child: const Center(
          child: Text(
            'Применить',
            style: TextStyle(
              color: Color(0x6600D1FF),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryFilterOption {
  const _CategoryFilterOption(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;

  String get labelPlain => label.replaceAll('\n', ' ');
}
