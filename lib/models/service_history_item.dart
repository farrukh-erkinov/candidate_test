enum ServiceStatus { inProgress, rejected, completed }

class ServiceHistoryItem {
  const ServiceHistoryItem({
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
  });

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
}
