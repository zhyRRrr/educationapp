import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MaterialApp(home: MyChart()));
}

class MyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('条形图和曲线图')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: BarChartSample()), // 使用 Expanded
            SizedBox(height: 20),
            Expanded(child: LineChartSample()), // 使用 Expanded
          ],
        ),
      ),
    );
  }
}

class BarChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 6,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 38,
              getTitlesWidget: (value, meta) {
                const titles = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
                return Text(titles[value.toInt()]);
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
              x: 0, barRods: [BarChartRodData(toY: 4, color: Colors.blue)]),
          BarChartGroupData(
              x: 1, barRods: [BarChartRodData(toY: 2, color: Colors.blue)]),
          BarChartGroupData(
              x: 2, barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
          BarChartGroupData(
              x: 3, barRods: [BarChartRodData(toY: 3, color: Colors.blue)]),
          BarChartGroupData(
              x: 4, barRods: [BarChartRodData(toY: 6, color: Colors.blue)]),
          BarChartGroupData(
              x: 5, barRods: [BarChartRodData(toY: 2, color: Colors.blue)]),
          BarChartGroupData(
              x: 6, barRods: [BarChartRodData(toY: 4, color: Colors.blue)]),
        ],
      ),
    );
  }
}

class LineChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 38,
              getTitlesWidget: (value, meta) {
                const titles = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
                return Text(titles[value.toInt()]);
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        maxY: 6, // 确保设置了最大值
        minX: 0, // 确保设置了最小值
        maxX: 6, // 确保设置了最大值
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 4),
              FlSpot(1, 2),
              FlSpot(2, 5),
              FlSpot(3, 3),
              FlSpot(4, 6),
              FlSpot(5, 2),
              FlSpot(6, 4),
            ],
            isCurved: true,
            color: Colors.lightBlueAccent,
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
