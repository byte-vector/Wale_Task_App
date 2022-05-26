import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_app/Components/ConstantMethods.dart';

class BarChartCard extends StatefulWidget {
  final double quantity2014;
  final double quantity2015;
  final double quantity2016;
  final double quantity2017;
  const BarChartCard(
      {Key? key,
      required this.quantity2014,
      required this.quantity2015,
      required this.quantity2016,
      required this.quantity2017})
      : super(key: key);

  @override
  State<BarChartCard> createState() => _BarChartCardState();
}

class _BarChartCardState extends State<BarChartCard> {
  late int showingTooltip;
  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
            gradient: LinearGradient(
                colors: [Colors.blueGrey.shade300, Colors.grey.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            fromY: 0,
            toY: y.toDouble(),
            width: 25,
            borderRadius: BorderRadius.circular(5)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Bar Chart\n Quantity shipped based on shipping date\n 4 Years",
            textAlign: TextAlign.center,
            style: kHeadingStyle(),
          ),
          kSizedBox(),
          kSizedBox(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: BarChart(
                    BarChartData(
                      barGroups: [
                        generateGroupData(2014, widget.quantity2014.toInt()),
                        generateGroupData(2015, widget.quantity2015.toInt()),
                        generateGroupData(2016, widget.quantity2016.toInt()),
                        generateGroupData(2017, widget.quantity2017.toInt()),
                      ],
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        drawHorizontalLine: true,
                      ),
                      borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                              color: Colors.grey.shade200,
                              style: BorderStyle.solid)),
                      titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: leftTitles,
                              reservedSize: 40,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              getTitlesWidget: bottomTitles,
                              showTitles: true,
                              reservedSize: 25,
                            ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                )
              ],
            ),
          ),
          kSizedBox()
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
    String text;
    if (value > 0 && value < 1000) {
      text = '1000';
    } else if (value > 1000 && value < 2000) {
      text = '2000';
    } else if (value > 2000 && value < 3000) {
      text = '3000';
    } else if (value > 3000 && value < 4000) {
      text = '4000';
    } else {
      return Container();
    }
    return Text(
      text,
      style: style,
    );
  }
}
