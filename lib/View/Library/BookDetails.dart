import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Cubit/Home/HomeScreenViewModel.dart';
import '../../Cubit/States/States.dart';
import '../../Utils/MyColors.dart';
import '../Home/home.dart';
import 'AllReviews.dart';
import '../../Utils/CommenConfirmSheet.dart';
import 'MoreDetailsScreen.dart';
import 'QRBorrowScreen.dart';

class BookDetailsScreen extends StatefulWidget {
  final String bookId;
  const BookDetailsScreen({super.key, required this.bookId});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  final PageController _pageController = PageController();
  bool showMore = false;



  @override
  void initState() {
    super.initState();

    context.read<HomeScreenCubit>().getBookDetails(widget.bookId);
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit,States>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Scaffold(
              backgroundColor: MyColors.whiteColor,
                body: Center(child: CircularProgressIndicator()));
          }
          if (state is BookDetailsSuccessState) {
            final book = state.book;

            return Scaffold(
              backgroundColor: MyColors.whiteColor,
              appBar: AppBar(
                backgroundColor: MyColors.whiteColor,
                elevation: 0,
                scrolledUnderElevation: 0,
                leading: IconButton(onPressed: (){
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(initialIndex: 1,),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                    icon: Icon(Icons.arrow_back)),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ---------- Book Image Slider ----------
                      SizedBox(
                        height: 250.h,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: book.gallery?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: MyColors.dividerColor,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.network(
                                  book.mainImage ??'' ,
                                  //fit: BoxFit.cover,
                                  // width: double.infinity,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: book.gallery!.length,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: MyColors.primaryColor,
                            dotColor: MyColors.outColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      /// ---------- Book Info ----------
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w
                        ),
                        child: Container(
                          padding: EdgeInsets.all(7.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            border: Border.all(
                                color: MyColors.outColor
                            ),
                          ),
                          child: Text(
                            "📘 ${book.categoryId?.name}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w
                        ),
                        child: Text(
                          book.name??'',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              color: MyColors.blackColor
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      Divider(
                        color: MyColors.dividerColor,
                        thickness: 10,
                      ),
                      SizedBox(height: 12.h),
                      _buildRow("Stock", "${book.numberInStock} books"),
                      _buildRow("Borrowed by", "${book.borrowedBy} students"),
                      _buildRow("Publisher", "${book.publisher}"),
                      _buildRow("Writer", "${book.writer}"),
                      _buildRow("Language", "${book.language}"),

                      SizedBox(height: 12.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w
                        ),
                        child: ElevatedButton(
                          onPressed: (){
                            // Navigator.of(context).pushReplacement(
                            //   PageRouteBuilder(
                            //     pageBuilder: (context, animation, secondaryAnimation) => SendCode(email: 'email'),
                            //     transitionDuration: Duration.zero,
                            //     reverseTransitionDuration: Duration.zero,
                            //   ),
                            // );
                            showMoreDetailsSheet(context,book);
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
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "View more details",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: MyColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),
                      Divider(
                        color: MyColors.dividerColor,
                        thickness: 10,
                      ),
                      SizedBox(height: 24.h),
                      /// ---------- Synopsis ----------
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w
                        ),
                        child: Text(
                          "Synopsis",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: MyColors.blackColor
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w
                        ),
                        child: Text(
                          "${book.synopsis}",
                          maxLines: showMore ? null : 3,
                          overflow:
                          showMore ? TextOverflow.visible : TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade700,
                              height: 1.5.h
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              showMore = !showMore;
                            });
                          },
                          child: Text(
                            showMore ? "Read less" : "Read more",
                            style: TextStyle(
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Divider(
                        color: MyColors.dividerColor,
                        thickness: 10,
                      ),
                      SizedBox(height: 24.h),
                      /// ---------- Reviews ----------
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Review",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: MyColors.blackColor
                              ),
                            ),
                            Text(
                              "01 mostly good",
                              style: TextStyle(
                                color: MyColors.greyColor,
                                fontSize: 13.sp,


                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        height: 150.h,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "jinny lim",
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.h,
                                              horizontal: 7.w
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50.r),
                                              border: Border.all(
                                                  color: MyColors.outColor
                                              )
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset('assets/images/star.svg'),
                                              Text(" 5/5",
                                                style: TextStyle(
                                                    fontSize: 12.sp, color: MyColors.blackColor,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      "Great selection for books ",
                                      style:
                                      TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "15 August 2025",
                                      style:
                                      TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: MyColors.outColor,
                                thickness: 1,
                                height: 16.h, // المسافة الرأسية بين العناصر
                                indent: 16.w, // بداية الخط من الشمال
                                endIndent: 16.w, // نهاية الخط من اليمين
                              );
                            },
                            itemCount: 2
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w
                        ),
                        child: ElevatedButton(
                          onPressed: (){
                            showAllReviewsSheet(context,book.id!);
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
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "View all reviews",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: MyColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Divider(
                        color: MyColors.dividerColor,
                        thickness: 10,
                      ),


                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 32.w
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          border: Border.all(
                              color: MyColors.outColor
                          )
                      ),
                      child: SvgPicture.asset('assets/images/frame.svg',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          showCommonBottomSheet(
                            context: context,
                            imagePath: 'assets/images/borrow.png',
                            title: 'Borrow this book now?',
                            description:
                            'Are you sure to borrow this book? Once you borrow, you must scan the QR to the librarian!',
                            primaryButtonText: 'Yes, borrow',
                            onPrimaryPressed: () {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => QRBorrowScreen(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            secondaryButtonText: 'Cancel',
                            onSecondaryPressed: () {
                              Navigator.pop(context);
                            },
                          );
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
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Borrow now",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: MyColors.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            );
          }

        return Center(child: Text("No Data"));
        }
    );



  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        vertical: 5.h
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العمود الأول (العناوين)
          SizedBox(
            width: 120.w, // 👈 حددي عرض ثابت لكل العناوين
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: MyColors.greyColor,
                fontWeight: FontWeight.w500
              ),
            ),
          ),

          // العمود الثاني (القيم)
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

}
