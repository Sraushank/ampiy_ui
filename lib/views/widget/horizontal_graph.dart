import 'package:flutter/material.dart';

import '../../controllers/rangeValueInList.dart';

class GraphHorizontalBar extends StatelessWidget {
  final List<Map<String, dynamic>> item;

  const GraphHorizontalBar({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final double upPercentage = rangeValueInList(0, 10, item);
    final double percentage = rangeValueInList(-3, 0, item);
    final double downPercentage = rangeValueInList(-10, 0, item) - percentage;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: upPercentage.toInt(),
                      child: Container(
                        height: 15,
                        color: Colors.green,
                      ),
                    ),
                    Expanded(
                      flex: percentage.toInt(),
                      child: Container(
                        height: 15,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      flex: downPercentage.toInt(),
                      child: Container(
                        height: 15,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Up: $upPercentage',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Down: $downPercentage',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


}
