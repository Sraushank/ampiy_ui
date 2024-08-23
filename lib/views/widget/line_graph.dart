import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../controllers/minusValueInList.dart';
import '../../controllers/plushValueInList.dart';
import '../../controllers/rangeValueInList.dart';

class GraphBar extends StatefulWidget {
  final List<Map<String, dynamic>> item;

  const GraphBar({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => GraphBarState();
}

class GraphBarState extends State<GraphBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 16),
          child: Text(
            'Market Variation Spectrum',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        Container(
          height: 100,
          child: _BarChart(item: widget.item),
        ),
      ],
    );
  }
}

class _BarChart extends StatelessWidget {
  final List<Map<String, dynamic>> item;

  const _BarChart({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        extraLinesData: ExtraLinesData(extraLinesOnTop: false),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 4,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = const TextStyle(
      color: Colors.white30,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '>10%';
        break;
      case 1:
        text = '7-10%';
        break;
      case 2:
        text = '5-7%';
        break;
      case 3:
        text = '3-5%';
        break;
      case 4:
        text = '0-3%';
        break;
      case 5:
        text = '0%';
        break;
      case 6:
        text = '3-5%';
        break;
      case 7:
        text = '5-7%';
        break;
      case 8:
        text = '7-10%';
        break;
      case 9:
        text = '>10%';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _defaultBarsGradient => const LinearGradient(
        colors: [
          Colors.red,
          Colors.red,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  LinearGradient get _otherBarsGradient => const LinearGradient(
        colors: [
          Colors.white70,
          Colors.white70,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  LinearGradient get _highlightBarsGradient => const LinearGradient(
        colors: [
          Colors.green,
          Colors.green,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  double get tileWidth => 17.0;

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: plushValueInList(10, item),
              gradient: _highlightBarsGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(1),
                right: Radius.circular(1),
              ),
              width: tileWidth,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: rangeValueInList(7, 10, item),
              gradient: _highlightBarsGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(1),
                right: Radius.circular(1),
              ),
              width: tileWidth,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: rangeValueInList(5, 7, item),
              gradient: _highlightBarsGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(1),
                right: Radius.circular(1),
              ),
              width: tileWidth,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: rangeValueInList(3, 5, item),
              gradient: _highlightBarsGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(1),
                right: Radius.circular(1),
              ),
              width: tileWidth,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: rangeValueInList(0, 3, item),
              gradient: _highlightBarsGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(1),
                right: Radius.circular(1),
              ),
              width: tileWidth,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: rangeValueInList(-3, 0, item),
              gradient: _otherBarsGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(1),
                right: Radius.circular(1),
              ),
              width: tileWidth,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: rangeValueInList(-5, -3, item),
              gradient: _defaultBarsGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(1),
                right: Radius.circular(1),
              ),
              width: tileWidth,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: rangeValueInList(-7, -5, item),
              gradient: _defaultBarsGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(1),
                right: Radius.circular(1),
              ),
              width: tileWidth,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              toY: rangeValueInList(-10, -7, item),
              gradient: _defaultBarsGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(1),
                right: Radius.circular(1),
              ),
              width: tileWidth,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              toY: minusValueInList(-10, item),
              gradient: _defaultBarsGradient,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(1),
                right: Radius.circular(1),
              ),
              width: tileWidth,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
