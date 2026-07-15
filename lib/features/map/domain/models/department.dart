class Department {
  const Department({
    required this.id,
    required this.name,
    required this.region,
    required this.progress,
    required this.isUnlocked,
  });

  final String id;
  final String name;
  final String region;
  final double progress;
  final bool isUnlocked;

  int get progressPercentage => (progress * 100).round();

  Department copyWith({
    String? id,
    String? name,
    String? region,
    double? progress,
    bool? isUnlocked,
  }) {
    return Department(
      id: id ?? this.id,
      name: name ?? this.name,
      region: region ?? this.region,
      progress: progress ?? this.progress,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}
