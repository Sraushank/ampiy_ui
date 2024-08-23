double minusValueInList(double value, List<Map<String, dynamic>> items) {
  double count = 0;
  for (var data in items) {
    double? dataValue = double.tryParse(data['P'].toString());
    if (dataValue != null && dataValue < value) {
      count++;
    }
  }
  return count;
}
