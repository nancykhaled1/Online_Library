import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utils/MyColors.dart';

Widget buildRow(String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 5.h
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// العمود الأول (العناوين)
        SizedBox(
          width: 120.w,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: MyColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        /// العمود الثاني (القيم)
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: MyColors.blackColor,
            ),
          ),
        ),
      ],
    ),
  );
}