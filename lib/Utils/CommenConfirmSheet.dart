import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'MyColors.dart';

Future<void> showCommonBottomSheet({
  required BuildContext context,
  required String imagePath, // الصورة
  required String title, // العنوان
  required String description, // الوصف
  required String primaryButtonText, // الزرار الرئيسي
  required VoidCallback onPrimaryPressed, // حدث الزرار الرئيسي
  required String secondaryButtonText, // الزرار الثانوي
  required VoidCallback onSecondaryPressed, // حدث الزرار الثانوي
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: MyColors.whiteColor,
    enableDrag: false,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 20.h),

            // 🔹 الصورة
            Image.asset(imagePath, height: 150.h, fit: BoxFit.contain),

            SizedBox(height: 15.h),

            // 🔹 العنوان
            Text(
              title,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: MyColors.blackColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 8.h),

            // 🔹 الوصف
            Text(
              description,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: MyColors.greyColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30.h),

            // 🔹 الأزرار
            Row(
              children: [
                // زرار الثانوي
                Expanded(
                  child: ElevatedButton(
                    onPressed: onSecondaryPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.whiteColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        side: BorderSide(color: MyColors.outColor),
                      ),
                    ),
                    child: Text(
                      secondaryButtonText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),

                // زرار الرئيسي
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPrimaryPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    child: Text(
                      primaryButtonText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
