import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Models/Responses/ReturnResponse.dart';
import '../../Utils/MyColors.dart';

void returnedSheet(BuildContext context, ReturnData data) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: MyColors.whiteColor,
    enableDrag: false,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (context) {

      return StatefulBuilder(
        builder: (context, setState) {

          // ⏳ تايمر 3 ساعات (10800 ثانية)
          int totalSeconds = 3 * 60 * 60;

          // تشغيل التايمر
          Timer.periodic(Duration(seconds: 1), (timer) {
            if (totalSeconds == 0) {
              timer.cancel();
              // لو عايزة الشيت يقفل لو وحده:
               Navigator.pop(context);
            } else {
              setState(() {
                totalSeconds--;
              });
            }
          });

          // تحويل الثواني لصيغة hh:mm:ss
          String formatTime(int seconds) {
            int h = seconds ~/ 3600;
            int m = (seconds % 3600) ~/ 60;
            int s = seconds % 60;
            return "${h.toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}";
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                // Handle bar
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                SizedBox(height: 20.h),

                // QR container
                Container(
                  padding: EdgeInsets.all(14.r),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: MyColors.primaryColor)),
                  child: Image.network(
                    data.qrCodeReturn!,
                    height: 200.h,
                  ),
                ),

                SizedBox(height: 20.h),

                // Info + Timer
                Container(
                  padding: EdgeInsets.all(10.r),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MyColors.dividerColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/info-circle.svg'),
                      SizedBox(width: 7.h),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Please show this QR to the librarian",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: MyColors.greyColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "to continue borrowing this book.",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: MyColors.greyColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 5),

                                // ⏳ التايمر هنا
                                Text(
                                  formatTime(totalSeconds),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: MyColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Cancel Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.whiteColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        side: BorderSide(color: MyColors.outColor)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: MyColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
