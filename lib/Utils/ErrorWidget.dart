import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/MyColors.dart';

class AppErrorWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? description;
  final VoidCallback onRetry;

  const AppErrorWidget({
    super.key,
    required this.imagePath,
    required this.title,
    this.description,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              width: 200.w,
              height: 200.h,
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: MyColors.blackColor,
              ),
            ),
            if (description != null) ...[
              SizedBox(height: 8.h),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: MyColors.greyColor,
                ),
              ),
            ],
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                backgroundColor: MyColors.primaryColor
              ),
              child: Text(
                "Reload",
                style: TextStyle(fontSize: 15.sp,
                color: MyColors.whiteColor
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
