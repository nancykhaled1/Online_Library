import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_library_app/View/ImageBuild.dart';


import '../../Models/Responses/BorrowResponse.dart';
import '../../Utils/MyColors.dart';
import '../Home/home.dart';
import '../widget.dart';
import 'BookDetails.dart';

class QRBorrowScreen extends StatefulWidget{
  final BorrowData borrowData; // بيانات الـ borrow اللى جت من Cubit

  const QRBorrowScreen({Key? key, required this.borrowData}) : super(key: key);

  @override
  State<QRBorrowScreen> createState() => _QRBorrowScreenState();
}

class _QRBorrowScreenState extends State<QRBorrowScreen> {
  int totalSeconds = 3 * 60 * 60; // 3 ساعات
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (totalSeconds == 0) {
        t.cancel();
        // اختياري: اقفلي الشاشة لو الوقت انتهى
        // Navigator.pop(context);
      } else {
        setState(() {
          totalSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int h = seconds ~/ 3600;
    int m = (seconds % 3600) ~/ 60;
    int s = seconds % 60;
    return "${h.toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}";
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: AppBar(
        backgroundColor: MyColors.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text("Borrow details"),
        titleTextStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: MyColors.blackColor
        ),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => BookDetailsScreen(bookId: widget.borrowData.borrow?.book?.id! ??'',),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w
              ),
              child: Container(
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

                                Text(formatTime(totalSeconds),
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
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w
              ),
              child: Container(
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
                child: //buildImage(borrowData.qrCodeBorrow)

                Image.network(widget.borrowData.qrCodeBorrow!,
                height: 200.h,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset("assets/images/book.png", height: 180.h,);
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Divider(color: MyColors.dividerColor, thickness: 10,),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w
              ),
              child: Text(
                "Information",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: MyColors.blackColor
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                children: [
                  buildRow("Borrow date", widget.borrowData.borrow!.borrowDate! ?? ''),
                  buildRow("Borrow time", widget.borrowData.borrow!.borrowTime! ?? ''),
                  buildRow("Must be returned", widget.borrowData.borrow!.mustReturnDate! ?? ''),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w
              ),
              child: Container(
                //padding: EdgeInsets.all(20.r),
                width: double.infinity,
                // height: 70.h,
                decoration: BoxDecoration(
                    color: MyColors.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                        color: MyColors.outColor
                    ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height:150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: MyColors.dividerColor,
                          borderRadius: BorderRadius.circular(12.r),

                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Image.network(widget.borrowData.borrow?.book!.mainImage ??'assets/images/book.png',
                            height: 200.h,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset("assets/images/book.png", height: 180.h,);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        widget.borrowData.borrow!.book!.name! ?? '',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: MyColors.blackColor
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        widget.borrowData.borrow!.book!.writer! ??'',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: MyColors.greyColor
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    ));
  }
}