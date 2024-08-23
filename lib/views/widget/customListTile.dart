import 'package:flutter/material.dart';
import '../../controllers/pascalcase.dart';
import '../../controllers/percentage.dart';

class CustomListTile extends StatefulWidget {
  var item;

  Color color;

  CustomListTile({super.key, required this.item, required this.color});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    int coinNameLength = widget.item['s'].length;
    String coinName = '';

    for (int coinNameIndex = 0;
        coinNameIndex < coinNameLength / 2;
        coinNameIndex++) {
      coinName += widget.item['s'][coinNameIndex];
    }

    return Container(
      color: widget.color,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text(widget.item['s'][0]),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${coinName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  // Title Text
                  Text("${toPascalCase(widget.item['s'])}",
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 15,
                      )),
                  // Title Text
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '₹ ${widget.item['c'] ?? '0.0'}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(width: 10), // Space between text and box
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black38),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: SizedBox(
                  height: 35,
                  width: 75,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.item['P'] != null &&
                                  double.tryParse(widget.item['P'])! < 0
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          size: 15,
                          color: widget.item['P'] != null &&
                                  double.tryParse(widget.item['P'])! < 0
                              ? Colors.red
                              : Colors.green,
                        ),
                        SizedBox(width: 5),
                        Text(
                          formatPercentage(widget.item['P']),
                          style: TextStyle(
                            color: widget.item['P'] != null &&
                                    double.tryParse(widget.item['P'])! < 0
                                ? Colors.red
                                : Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
