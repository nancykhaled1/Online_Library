import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../Utils/MyColors.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final bool read;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.body,
    required this.date,
    required this.read
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // حاولنا نعمل فورمات للتاريخ لو اتبعت صح من الـ API

    final DateTime parsedDate = DateTime.parse(date ).toLocal();
    final String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    final String formattedTime = DateFormat('HH:mm').format(parsedDate);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
              color: read ? MyColors.whiteColor : MyColors.outColor,
              borderRadius: BorderRadius.circular(10.r)
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: read ? MyColors.outColor : MyColors.whiteColor,
                    borderRadius: BorderRadius.circular(10.r)
                    ),

                  child: Center(
                    child: Image.asset(
                      'assets/images/Fire.png',
                      width: 24.w,
                      height: 24.h,
                      // color: MyColors.whiteColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1, // 👈 ياخد سطر واحد بس
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: MyColors.blackColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        body,
                        maxLines: 1, // 👈 ياخد سطر واحد بس
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: MyColors.greyColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: MyColors.greyColor,
                            ),
                          ),
                          Text(
                            formattedTime,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: MyColors.greyColor,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h,)

      ],
    );
  }
}
