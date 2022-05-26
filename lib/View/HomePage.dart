import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_app/Components/BarChart.dart';
import 'package:task_app/Components/CompositeBarChart.dart';
import 'package:task_app/Components/ConstantMethods.dart';
import 'package:task_app/Components/PieChartCard.dart';
import 'package:task_app/Components/TimeChart.dart';
import 'package:task_app/Model/CustomerDataModel.dart';
import 'package:task_app/Services/Webservices.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Webservices _webservices = Webservices();
  List<CustomerData>? _listOfData;
  bool _loading = true;
  double _westSales = 0.0;
  double _eastSales = 0.0;
  double _northSales = 0.0;
  double _southSales = 0.0;
  double _centralSales = 0.0;
  double _quantity2014 = 0.0;
  double _quantity2015 = 0.0;
  double _quantity2016 = 0.0;
  double _quantity2017 = 0.0;
  double _profit2014 = 0.0, _sales2014 = 0.0;
  double _profit2015 = 0.0, _sales2015 = 0.0;
  double _profit2016 = 0.0, _sales2016 = 0.0;
  double _profit2017 = 0.0, _sales2017 = 0.0;
  final List<String> _listOfOptions = ["Segments", "Category", "Sub-Category"];

  //Method to calculate sales on basis of regions
  Future<void> caculateSale() async {
    print(_listOfData);
    if (_listOfData!.isNotEmpty) {
      _listOfData!.forEach((element) {
        switch (element.region) {
          case "East":
            setState(() {
              _eastSales = _eastSales + double.parse(element.sales!);
            });
            break;
          case "West":
            setState(() {
              _westSales = _westSales + double.parse(element.sales!);
            });
            break;
          case "North":
            setState(() {
              _northSales = _northSales + double.parse(element.sales!);
            });
            break;
          case "South":
            setState(() {
              _southSales = _southSales + double.parse(element.sales!);
            });
            break;
          case "Central":
            setState(() {
              _centralSales = _centralSales + double.parse(element.sales!);
            });
            break;
          default:
        }
      });
    }
  }

  //Method to calculate quantity based on Ship Year
  Future<void> caculateQuantity() async {
    if (_listOfData!.isNotEmpty) {
      _listOfData!.forEach((element) {
        var year = element.shipDate!.split("/").last;
        switch (year) {
          case "2017":
            setState(() {
              _quantity2017 = _quantity2017 + double.parse(element.quantity!);
            });
            break;
          case "2016":
            setState(() {
              setState(() {
                _quantity2016 = _quantity2016 + double.parse(element.quantity!);
              });
            });
            break;
          case "2015":
            setState(() {
              _quantity2015 = _quantity2015 + double.parse(element.quantity!);
            });
            break;
          case "2014":
            setState(() {
              _quantity2014 = _quantity2014 + double.parse(element.quantity!);
            });
            break;
          default:
            throw "Error in calculate Quantity Switch Case!!!";
        }
      });
    }
  }

  //Method to calculate profit and sales of 4 years
  void calculateProfitnSales() async {
    if (_listOfData!.isNotEmpty) {
      _listOfData!.forEach((element) {
        var year = element.shipDate!.split("/").last;
        switch (year) {
          case "2017":
            setState(() {
              _profit2017 = _profit2017 + double.parse(element.profit!);
              _sales2017 = _sales2017 + double.parse(element.sales!);
            });
            break;
          case "2016":
            setState(() {
              setState(() {
                _profit2016 = _profit2016 + double.parse(element.profit!);
                _sales2016 = _sales2016 + double.parse(element.sales!);
              });
            });
            break;
          case "2015":
            setState(() {
              _profit2015 = _profit2015 + double.parse(element.profit!);
              _sales2015 = _sales2015 + double.parse(element.sales!);
            });
            break;
          case "2014":
            setState(() {
              _profit2014 = _profit2014 + double.parse(element.profit!);
              _sales2014 = _sales2014 + double.parse(element.sales!);
            });
            break;
          default:
            throw "Error in calculate Profit & Sales Switch Case!!!";
        }
      });
    }
  }

  Future<void> callAPI() async {
    await _webservices.getCustomerData().then((value) {
      if (value != null) {
        setState(() {
          _listOfData = value;
          _loading = false;
        });
      }
    });
  }

  @override
  void initState() {
    callAPI().whenComplete(() {
      caculateSale().whenComplete(() {
        caculateQuantity().whenComplete(() {
          calculateProfitnSales();
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(7.0.w)))),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0.w),
                                topRight: Radius.circular(5.0.w))),
                        context: context,
                        builder: (_) => ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0.w),
                                  topRight: Radius.circular(5.0.w)),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.0.w),
                                        topRight: Radius.circular(5.0.w))),
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.0.h, horizontal: 3.0.w),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) => ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        title: Text(
                                          "${_listOfOptions[index]}",
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 18.0.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  itemCount: _listOfOptions.length,
                                ),
                              ),
                            ));
                  },
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.filter,
                        color: Colors.white,
                        size: 18.0.sp,
                      ),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Text(
                        "Filter",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
            ),
            SizedBox(
              width: 2.0.w,
            )
          ],
        ),
        body: _loading
            ? const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    kSizedBox(),
                    kSizedBox(),
                    kSizedBox(),
                    PieChartCard(
                        x1: _eastSales,
                        x2: _westSales,
                        x3: _northSales,
                        x4: _southSales,
                        x5: _centralSales),
                    kSizedBox(),
                    kSizedBox(),
                    BarChartCard(
                      quantity2014: _quantity2014,
                      quantity2015: _quantity2015,
                      quantity2016: _quantity2016,
                      quantity2017: _quantity2017,
                    ),
                    kSizedBox(),
                    kSizedBox(),
                    CompositeBarChart(
                        profit2014: _profit2014,
                        profit2015: _profit2015,
                        profit2016: _profit2016,
                        profit2017: _profit2017,
                        sales2014: _sales2014,
                        sales2015: _sales2015,
                        sales2016: _sales2016,
                        sales2017: _sales2017),
                    kSizedBox(),
                    kSizedBox(),
                    TimeChart(
                        profit2014: _profit2014,
                        profit2015: _profit2015,
                        profit2016: _profit2016,
                        profit2017: _profit2017),
                    kSizedBox(),
                    kSizedBox(),
                  ],
                ),
              ));
  }
}
