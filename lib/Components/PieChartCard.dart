import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task_app/Components/ConstantMethods.dart';

class PieChartCard extends StatefulWidget {
  final double x1;
  final double x2;
  final double x3;
  final double x4;
  final double x5;
  const PieChartCard(
      {Key? key,
      required this.x1,
      required this.x2,
      required this.x3,
      required this.x4,
      required this.x5})
      : super(key: key);

  @override
  State<PieChartCard> createState() => _PieChartCardState();
}

class _PieChartCardState extends State<PieChartCard> {
  int touchedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0.h,
      margin: EdgeInsets.symmetric(horizontal: 2.0.w),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          kSizedBox(),
          Text(
            "Pie Chart Sales\n On Region",
            textAlign: TextAlign.center,
            style: kHeadingStyle(),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10.0.w,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      key: widget.key,
                      PieChartData(
                          pieTouchData: PieTouchData(touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          }),
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 0,
                          centerSpaceRadius: 0,
                          sections: showingSections()),
                      swapAnimationDuration:
                          Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear, // Optional
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 6.0.w, 3.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          kIndicator(Color(0xffF1E15B), "East"),
                          kIndicator(Color(0xffE8C19F), "West"),
                          kIndicator(Color(0xff845bef), "North"),
                          kIndicator(Color(0xff61CDBB), "South"),
                        ],
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget kIndicator(Color color, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            FontAwesomeIcons.chartPie,
            size: 18.0.sp,
            color: color,
          ),
          SizedBox(
            width: 3.0.w,
          ),
          Text(
            label,
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 15.5.sp,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 15.0.sp : 13.0.sp;
      final radius = isTouched ? 110.0 : 100.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffF1E15B),
            value: widget.x1,
            title: widget.x1.toStringAsFixed(2),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffE8C19F),
            value: widget.x2,
            title: widget.x2.toStringAsFixed(2),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: widget.x3,
            title: widget.x3.toStringAsFixed(2),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff61CDBB),
            value: widget.x4,
            title: widget.x4.toStringAsFixed(2),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey),
          );
        default:
          throw 'Some Error in Pie Chart Get Sections!!';
      }
    });
  }
}
