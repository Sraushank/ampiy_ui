double rangeValueInList(
    double minValue, double maxValue, List<Map<String, dynamic>> items) {
  double count = 0;
  for (var data in items) {
    double? dataValue = double.tryParse(data['P'].toString());
    if (dataValue != null && dataValue < maxValue && dataValue > minValue) {
      count++;
    }
  }
  return count;
}
