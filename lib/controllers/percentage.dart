String formatPercentage(String percentage) {
  double value = double.parse(percentage.replaceAll('%', ''));
  String formattedValue = value.toStringAsFixed(2);
  if (percentage.isNotEmpty) {
    return '$formattedValue%';
  } else {
    return '0.0%';
  }
}
