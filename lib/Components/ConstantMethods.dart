import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Method For Constant Vertical Spaces between Widgets
SizedBox kSizedBox() {
  return SizedBox(
    height: 2.5.h,
  );
}

// Method For Constant Heading Text Style
TextStyle kHeadingStyle() {
  return TextStyle(
      color: Colors.black45, fontSize: 18.0.sp, fontWeight: FontWeight.bold);
}
