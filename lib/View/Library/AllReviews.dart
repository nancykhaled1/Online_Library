import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../Cubit/Home/HomeScreenViewModel.dart';
import '../../Cubit/Home/ReviewViewModel.dart';
import '../../Cubit/States/States.dart';
import '../../Models/Requests/ReviewRequest.dart';
import '../../Utils/MyColors.dart';
import '../../Utils/dialog.dart';

void showAllReviewsSheet(BuildContext context, String bookId) {
  bool isWritingReview = false;
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
                    BlocBuilder<ReviewCubit, States>(
                      builder: (context, state) {
                        int reviewsCount = 0;

                        if (state is GetReviewSuccessState) {
                          reviewsCount = state.review.length;
                        }
                        return Text(
                          isWritingReview ? "Write a Review" : "Review ($reviewsCount)",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: MyColors.blackColor,
                          ),
                        );
                      },
                    ),

                    /// زرار Write review
                    if (!isWritingReview)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 16.w,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isWritingReview = true; // اظهار فورم الريفيو
                          });
                        },
                        child: Row(
                          children: [Icon(Icons.edit,color: MyColors.whiteColor,),
                            SizedBox(width: 5.w,),
                            Text("Write a review",
                              style: TextStyle(
                                color: MyColors.whiteColor
                              ),

                            )],
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 16.h),

                /// ***** لو بيكتب ريفيو → اعرض الفورم *****
                if (isWritingReview) ...[
                  Text("Your Rating:", style: TextStyle(fontSize: 14.sp)),
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
                          color:
                              (ratingValue <= selectedRating)
                                  ? Colors.amber
                                  : MyColors.greyColor,
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
                        context.read<ReviewCubit>().submitBookReview(
                          ReviewRequest(
                            bookId: bookId,
                            comment: reviewController.text,
                            rating: selectedRating.toString(),
                          ),
                        );

                        Navigator.pop(context);
                      },
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
                      child: Text("Submit Review",
                      style: TextStyle(
                        color: MyColors.whiteColor
                      ),
                      ),
                    ),
                  ),
                ],

                /// ***** لو مش بيكتب ريفيو → اعرض الريفيوهات *****
                if (!isWritingReview) ...[
                  BlocBuilder<ReviewCubit, States>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return Center(child: CircularProgressIndicator());
                      }

                      else if (state is ErrorState) {
                        final error = state.errorMessage;

                        if (error == "No Internet Connection") {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/noconnection.svg", // 🖼️ ضيفي صورة عندك
                                width: 200,
                                height: 200,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "No internet connection",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: MyColors.greyColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Noto Kufi Arabic",
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(
                              "Please, Try again later",
                              style: TextStyle(
                                color: MyColors.greyColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          );
                        }

                      }

                      if (state is GetReviewSuccessState) {
                        final reviews = state
                            .review; // الريفيوهات الجاية من الـ API
                        if (reviews.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Center(
                              child: Text(
                                "No reviews yet",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        }
                        double overallScore = 0;
                        if (reviews.isNotEmpty) {
                          double total = 0;
                          for (var review in reviews) {
                            // حول أي نوع لـ String أولًا
                            final ratingStr = review.rating?.toString() ?? "0";
                            total += double.tryParse(ratingStr) ?? 0;
                          }
                          overallScore = total / reviews.length;
                        }


                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 70.h,
                              decoration: BoxDecoration(
                                color: MyColors.dividerColor,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: MyColors.outColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/star.svg'),
                                      SizedBox(width: 4.w,),
                                      Text(
                                        "${overallScore}",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: MyColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Overal score",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: MyColors.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),

                            SizedBox(
                              height: 300.h, // some fixed or relative height

                              child: ListView.separated(
                                itemCount: reviews.length,
                                separatorBuilder:
                                    (_, __) =>
                                    Divider(
                                      color: MyColors.outColor,
                                      thickness: 1,
                                      indent: 16.w,
                                      endIndent: 16.w,
                                      height: 16.h,
                                    ),
                                itemBuilder: (context, index) {
                                  final review = reviews[index];

                                  final parsedDate =
                                  DateTime.parse(review.createdAt!).toLocal();
                                  final formattedDate = DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(parsedDate);

                                  final formattedTime = DateFormat(
                                    'HH:mm',
                                  ).format(parsedDate);
                                  String? imageUrl = review.userId?.photo;
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 15.r,
                                              backgroundColor: MyColors.whiteColor,
                                              child: ClipOval(
                                                child: imageUrl != null && imageUrl.isNotEmpty
                                                    ? Image.network(
                                                  "$imageUrl?v=${DateTime.now().millisecondsSinceEpoch}",
                                                  key: UniqueKey(),
                                                  fit: BoxFit.cover,
                                                  width: 100.w,
                                                  height: 100.h,
                                                  loadingBuilder: (context, child, loadingProgress) {
                                                    if (loadingProgress == null) return child;
                                                    return const Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  },
                                                  errorBuilder: (context, error, stackTrace) =>
                                                      Image.asset('assets/images/personalImage.png',
                                                          fit: BoxFit.fill,
                                                          width: 100.w,
                                                          height: 100.h
                                                      ),
                                                )
                                                    : Image.asset(
                                                  'assets/images/personalImage.png',
                                                  fit: BoxFit.cover,
                                                  width: 100.w,
                                                  height: 100.h,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Text(
                                              review.userId?.name ??'Anonymous',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 5.h,
                                                horizontal: 7.w,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(50.r),
                                                border: Border.all(
                                                  color: MyColors.outColor,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/star.svg',
                                                  ),
                                                  Text(
                                                    "${review.rating}/5",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          review.comment??'no comment',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              formattedDate,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                            Text(
                                              formattedTime,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return Container(); // default

                    },

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
