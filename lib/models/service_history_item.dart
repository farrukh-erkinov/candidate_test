enum ServiceStatus { inProgress, rejected, completed }

enum ServicePeriod { all, last7 }

extension ServiceStatusLabel on ServiceStatus {
  String get label {
    return switch (this) {
      ServiceStatus.inProgress => 'В процессе',
      ServiceStatus.rejected => 'Отказан',
      ServiceStatus.completed => 'Завершен',
    };
  }
}

extension ServicePeriodLabel on ServicePeriod {
  String get label {
    return switch (this) {
      ServicePeriod.all => 'Весь период',
      ServicePeriod.last7 => 'Последние 7 дней',
    };
  }
}

class ServiceHistoryItem {
  const ServiceHistoryItem({
    required this.id,
    this.providerName,
    this.providerLogoAsset,
    this.rating,
    required this.status,
    required this.category,
    required this.categoryIconAsset,
    required this.dateLabel,
    required this.dateValue,
    required this.odometer,
    required this.cost,
    this.compact = false,
    this.showChevron = true,
    this.showInDefault = true,
    this.isRecent = false,
    this.details = const [],
    this.showCarPreview = false,
  });

  final String id;
  final String? providerName;
  final String? providerLogoAsset;
  final double? rating;
  final ServiceStatus status;
  final String category;
  final String categoryIconAsset;
  final String dateLabel;
  final String dateValue;
  final String odometer;
  final String cost;
  final bool compact;
  final bool showChevron;
  final bool showInDefault;
  final bool isRecent;
  final List<String> details;
  final bool showCarPreview;
}

class ServiceHistoryFilter {
  const ServiceHistoryFilter({
    this.categories = const {},
    this.status,
    this.period = ServicePeriod.all,
  });

  final Set<String> categories;
  final ServiceStatus? status;
  final ServicePeriod period;

  bool get hasActiveFilters {
    return categories.isNotEmpty ||
        status != null ||
        period != ServicePeriod.all;
  }

  bool hasSameValuesAs(ServiceHistoryFilter other) {
    if (status != other.status || period != other.period) {
      return false;
    }
    if (categories.length != other.categories.length) {
      return false;
    }

    return categories.every(other.categories.contains);
  }

  int get activeCount {
    return categories.length +
        (status == null ? 0 : 1) +
        (period == ServicePeriod.all ? 0 : 1);
  }

  ServiceHistoryFilter copyWith({
    Set<String>? categories,
    ServiceStatus? status,
    bool clearStatus = false,
    ServicePeriod? period,
  }) {
    return ServiceHistoryFilter(
      categories: categories ?? this.categories,
      status: clearStatus ? null : status ?? this.status,
      period: period ?? this.period,
    );
  }

  bool matches(ServiceHistoryItem item) {
    if (categories.isNotEmpty && !categories.contains(item.category)) {
      return false;
    }
    if (status != null && item.status != status) {
      return false;
    }
    if (period == ServicePeriod.last7 && !item.isRecent) {
      return false;
    }

    return true;
  }

  ServiceHistoryFilter removeCategory(String category) {
    return copyWith(categories: {...categories}..remove(category));
  }

  ServiceHistoryFilter removeStatus() {
    return copyWith(clearStatus: true);
  }

  ServiceHistoryFilter removePeriod() {
    return copyWith(period: ServicePeriod.all);
  }
}
