import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Cubit/Home/HomeScreenViewModel.dart';
import '../../Models/Requests/ReviewRequest.dart';
import '../../Utils/MyColors.dart';

void showAllReviewsSheet(BuildContext context , String bookId) {
  bool isWritingReview = false; // لو true → يعرض الفورم بدل الليست
  int selectedRating = 0;
  TextEditingController reviewController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                /// Handle
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

                /// العنوان + زرار Write
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isWritingReview ? "Write a Review" : "Review (61)",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: MyColors.blackColor),
                    ),

                    /// زرار Write review
                    if (!isWritingReview)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isWritingReview = true; // اظهار فورم الريفيو
                          });
                        },
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            Text("Write a review")
                          ],
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 16.h),

                /// ***** لو بيكتب ريفيو → اعرض الفورم *****
                if (isWritingReview) ...[
                  Text(
                    "Your Rating:",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 10.h),

                  Row(
                    children: List.generate(5, (index) {
                      int ratingValue = index + 1;
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            selectedRating = ratingValue;
                          });
                        },
                        icon: Icon(
                          Icons.star,
                          size: 32,
                          color: (ratingValue <= selectedRating)
                              ? Colors.amber
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 15.h),

                  TextField(
                    controller: reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Write your comment...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedRating == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please choose a rating")),
                          );
                          return;
                        }

                        if (reviewController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please write a review")),
                          );
                          return;
                        }

                        /// Call cubit
                        context.read<HomeScreenCubit>().submitBookReview(
                          ReviewRequest(
                            bookId: bookId,
                            comment: reviewController.text,
                            rating: selectedRating.toString(),
                          ),
                        );

                        Navigator.pop(context);
                      },
                      child: Text("Submit Review"),
                    ),
                  )
                ],

                /// ***** لو مش بيكتب ريفيو → اعرض الريفيوهات *****
                if (!isWritingReview) ...[
                  Container(
                    width: double.infinity,
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: MyColors.dividerColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: MyColors.outColor)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/images/star.svg'),
                            Text(
                              " 4.9",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: MyColors.blackColor),
                            ),
                          ],
                        ),
                        Text(
                          "Overal score",
                          style: TextStyle(
                              fontSize: 12.sp, color: MyColors.greyColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Expanded(
                    child: ListView.separated(
                      itemCount: 5,
                      separatorBuilder: (_, __) => Divider(
                        color: MyColors.outColor,
                        thickness: 1,
                        indent: 16.w,
                        endIndent: 16.w,
                        height: 16.h,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "jinny lim",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 7.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(50.r),
                                        border: Border.all(
                                            color: MyColors.outColor)),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/star.svg'),
                                        Text(
                                          " 5/5",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "Great selection for books ",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.grey.shade700),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "15 August 2025",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      );
    },
  );
}

