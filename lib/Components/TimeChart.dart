import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_app/Components/ConstantMethods.dart';

class TimeChart extends StatefulWidget {
  final double profit2014;
  final double profit2015;
  final double profit2016;
  final double profit2017;
  const TimeChart(
      {Key? key,
      required this.profit2014,
      required this.profit2015,
      required this.profit2016,
      required this.profit2017})
      : super(key: key);

  @override
  State<TimeChart> createState() => _TimeChartState();
}

class _TimeChartState extends State<TimeChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 3.0.w),
      margin: EdgeInsets.symmetric(horizontal: 2.0.w),
      height: 50.0.h,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
          borderRadius: BorderRadius.circular(2.5.w),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                spreadRadius: 4,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          kSizedBox(),
          Text(
            "Time Chart\n Profits based on shipping date\n 4 Years",
            textAlign: TextAlign.center,
            style: kHeadingStyle(),
          ),
          kSizedBox(),
          kSizedBox(),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: LineChart(LineChartData(
                  gridData: FlGridData(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        interval: 50000,
                        showTitles: false,
                        getTitlesWidget: leftTitles,
                        reservedSize: 50,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        getTitlesWidget: bottomTitles,
                        showTitles: true,
                        reservedSize: 25,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: false,
                      color: Colors.orange,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: false,
                        color: const Color(0x00aa4cfc),
                      ),
                      spots: [
                        FlSpot(2014, widget.profit2014),
                        FlSpot(2015, widget.profit2015),
                        FlSpot(2016, widget.profit2016),
                        FlSpot(2017, widget.profit2017),
                      ],
                    )
                  ])),
            ),
          ),
          kSizedBox(),
        ],
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    if (value == 2014) {
      text = '2014';
    } else if (value == 2015) {
      text = '2015';
    } else if (value == 2016) {
      text = '2016';
    } else if (value == 2017) {
      text = '2017';
    } else {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        text,
        style: style,
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text = "";
    print(value);
    if (value.toInt() >= 0 && value < 5000) {
      text = "5000";
    } else if (value.toInt() >= 5000 && value.toInt() < 10000) {
      text = '10000';
    } else if (value.toInt() >= 10000 && value.toInt() < 15000) {
      text = '15000';
    } else if (value.toInt() >= 15000 && value.toInt() < 20000) {
      text = '20000';
    } else if (value.toInt() >= 20000 && value.toInt() < 25000) {
      text = '25000';
    } else {
      return Container();
    }
    return Text(
      text,
      style: style,
    );
  }
}
