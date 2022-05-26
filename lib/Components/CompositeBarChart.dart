import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_app/Components/ConstantMethods.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CompositeBarChart extends StatefulWidget {
  final double profit2014, sales2014;
  final double profit2015, sales2015;
  final double profit2016, sales2016;
  final double profit2017, sales2017;
  const CompositeBarChart(
      {Key? key,
      required this.profit2014,
      required this.profit2015,
      required this.profit2016,
      required this.profit2017,
      required this.sales2014,
      required this.sales2015,
      required this.sales2016,
      required this.sales2017})
      : super(key: key);

  @override
  State<CompositeBarChart> createState() => _CompositeBarChartState();
}

class _CompositeBarChartState extends State<CompositeBarChart> {
  late int showingTooltip;
  double spaceBtwn = 2;
  bool _salesActive = true;
  bool _profitActive = true;
  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y1, int y2) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        _profitActive
            ? BarChartRodData(
                gradient: LinearGradient(
                    colors: [Colors.blueGrey.shade300, Colors.grey.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                fromY: 0,
                toY: y1.toDouble(),
                width: 25,
                borderRadius: _salesActive
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5))
                    : const BorderRadius.all(Radius.circular(5)))
            : BarChartRodData(
                gradient: LinearGradient(
                    colors: [Colors.blueGrey.shade300, Colors.grey.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                fromY: 0,
                toY: 0,
                width: 25,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
        _salesActive
            ? BarChartRodData(
                gradient: const LinearGradient(
                    colors: [Colors.grey, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                fromY: _profitActive ? y1.toDouble() : 0,
                toY: y2.toDouble(),
                width: 25,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)))
            : BarChartRodData(
                gradient: const LinearGradient(
                    colors: [Colors.grey, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                fromY: 0,
                toY: 0,
                width: 25,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Composite Bar Chart\n Profit & Sales based on shipping date\n 4 Years",
            textAlign: TextAlign.center,
            style: kHeadingStyle(),
          ),
          kSizedBox(),
          kSizedBox(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AspectRatio(
                  aspectRatio: 0.95,
                  child: BarChart(
                    BarChartData(
                      barGroups: [
                        generateGroupData(2014, widget.profit2014.toInt(),
                            widget.sales2014.toInt()),
                        generateGroupData(2015, widget.profit2015.toInt(),
                            widget.sales2015.toInt()),
                        generateGroupData(2016, widget.profit2016.toInt(),
                            widget.sales2016.toInt()),
                        generateGroupData(2017, widget.profit2017.toInt(),
                            widget.sales2017.toInt()),
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
                          )),
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _salesActive
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    _salesActive = !_salesActive;
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.chartSimple,
                                      size: 19.0.sp,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    Text(
                                      "Sales",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.5.sp,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    _salesActive = !_salesActive;
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.chartSimple,
                                      size: 19.0.sp,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    Text(
                                      "Sales",
                                      style: TextStyle(
                                          color: Colors.grey.shade300,
                                          fontSize: 17.5.sp,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        _profitActive
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    _profitActive = !_profitActive;
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.chartSimple,
                                      size: 19.0.sp,
                                      color: Colors.blueGrey,
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    Text(
                                      "Profit",
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 17.5.sp,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    _profitActive = !_profitActive;
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.chartSimple,
                                      size: 19.0.sp,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(
                                      width: 2.0.w,
                                    ),
                                    Text(
                                      "Profit",
                                      style: TextStyle(
                                          color: Colors.grey.shade300,
                                          fontSize: 17.5.sp,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ],
                )),
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
    if (value > 0 && value < 5000) {
      text = '50000';
    } else if (value > 5000 && value < 10000) {
      text = '100000';
    } else if (value > 10000 && value < 15000) {
      text = '150000';
    } else if (value > 15000 && value < 20000) {
      text = '200000';
    } else if (value > 20000 && value < 25000) {
      text = '250000';
    } else {
      return Container();
    }
    return Text(
      text,
      style: style,
    );
  }
}
