class LungPercentage {
  const LungPercentage({
    required this.name,
    required this.percentage,
  });
  final String name;
  final double percentage;

  @override
  String toString() => 'name: $name, percentage: $percentage';
}
