import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../Models/Responses/GetBorrowResponse.dart';
import '../../Utils/MyColors.dart';
import '../Home/home.dart';
import '../Library/MoreDetailsScreen.dart';
import 'ReturnSheet.dart';


class ReturnedScreen extends StatelessWidget{
  Returned returnedBook;
  ReturnedScreen({super.key, required this.returnedBook});
  @override
  Widget build(BuildContext context) {
    final parsedDate =
    DateTime.parse(returnedBook.borrowDate!).toLocal();
    final formattedDate = DateFormat(
      'dd/MM',
    ).format(parsedDate);

    final formattedTime = DateFormat(
      'HH:mm',
    ).format(parsedDate);

    final Date =
    DateTime.parse(returnedBook.returnedAt!).toLocal();
    final returnDate = DateFormat(
      'dd/MM',
    ).format(Date);
    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: SafeArea(child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: AppBar(
          backgroundColor: MyColors.whiteColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(onPressed: (){
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(initialIndex: 2),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              width: double.infinity,
              // height: 70.h,
              decoration: BoxDecoration(
                color: MyColors.darkGreenColor,
              ),
              child:
              Text(
                "Returned",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: MyColors.whiteColor
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
                  buildRow("Borrow date", formattedDate),
                  buildRow("Borrow time", returnedBook.borrowTime ??''),
                  buildRow("Returned on", returnDate),
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
                          child: Image.network(returnedBook.bookId!.mainImage ??'assets/images/book.png',
                            height: 200.h,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset("assets/images/book.png", height: 180.h,);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        returnedBook.bookId?.name ?? 'no name',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: MyColors.blackColor
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        returnedBook.bookId?.writer ??'no writer',
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
        // bottomNavigationBar: Padding(
        //   padding: EdgeInsets.all(16.r),
        //   child: ElevatedButton(
        //     onPressed: (){
        //       returnedSheet(context);
        //     },
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: MyColors.primaryColor,
        //       padding: EdgeInsets.symmetric(
        //         vertical: 12.h,
        //         horizontal: 16.w,
        //       ),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(50.r),
        //       ),
        //     ),
        //     child:
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           "Return",
        //           style: TextStyle(
        //             fontSize: 14.sp,
        //             color: MyColors.whiteColor,
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ],
        //     ),
        //
        //   ),
        // ),
      )
      ),
    );
  }

}