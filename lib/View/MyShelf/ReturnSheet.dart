import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Utils/MyColors.dart';

void returnedSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: MyColors.whiteColor,
    enableDrag: false,
    isDismissible: false,
    shape:  RoundedRectangleBorder(
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
            Container(
              padding: EdgeInsets.all(14.r),
              width: double.infinity,
              // height: 70.h,
              decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                      color: MyColors.primaryColor
                  )
              ),
              child: Image.asset('assets/images/QR Code.png'),
            ),
            SizedBox(height: 20.h),

            Container(
              padding: EdgeInsets.all(10.r),
              width: double.infinity,
              // height: 70.h,
              decoration: BoxDecoration(
                color: MyColors.dividerColor,
                borderRadius: BorderRadius.circular(12.r),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/images/info-circle.svg'),
                      SizedBox(width: 7.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Please show this QR to the librarian",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12.sp, color: MyColors.greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text("to continue borrowing this book.",
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 12.sp, color: MyColors.greyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 5.h),

                              Text(" timer",
                                style: TextStyle(
                                    fontSize: 12.sp, color: MyColors.blackColor,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            ElevatedButton(
              onPressed: (){
                 Navigator.pop(context); // يقفل الـ BottomSheet

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.whiteColor,
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 16.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  side: BorderSide(
                    color: MyColors.outColor
                  )
                ),
              ),
              child:
              Row(
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
}
