import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/MyColors.dart';

void showMoreDetailsSheet(BuildContext context,dynamic book) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: 16.w,
          right: 16.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// السطر الصغير فوق كأنه handle
            Center(
              child: Container(
                width: 50.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: MyColors.outColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              "Book information",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.blackColor
              ),
            ),

            SizedBox(height: 16.h),
            buildRow("Stock", "${book.numberInStock} books"),
            buildRow("Borrowed by", "${book.borrowedBy} students"),

            SizedBox(height: 12.h),

            Divider(color: MyColors.dividerColor, thickness: 10,
            ),
            SizedBox(height: 12.h),
            Text(
              "Book identity",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.blackColor
              ),
            ),

            buildRow("Title", book.name ?? ""),
            buildRow("Writer", book.writer ?? ""),
            buildRow("Publisher", book.publisher ?? ""),
            buildRow("Year published", "${book.publishYear ?? ""}"),
            buildRow("Edition", book.edition ?? ""),
            buildRow("No. of pages", "${book.numPages ?? ""} pages"),
            buildRow("Condition", book.condition ?? ""),
            buildRow("Weight", "${book.weight ?? ""} gm"),


            SizedBox(height: 10.h),
          ],
        ),
      );
    },
  );
}

/// الدالة اللى بتبني الصف الواحد
Widget buildRow(String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.h),
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
