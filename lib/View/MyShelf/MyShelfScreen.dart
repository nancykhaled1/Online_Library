import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:online_library_app/Cubit/MyShelf/BorrowViewModel.dart';
import 'package:online_library_app/Cubit/States/States.dart';

import '../../Cubit/MyShelf/SaveListViewModel.dart';
import '../../Utils/MyColors.dart';
import '../ImageBuild.dart';
import '../Library/BookDetails.dart';
import 'OnBorrowScreen.dart';
import 'ReturnedScreen.dart';


class MyShelfScreen extends StatefulWidget {
  static const String routeName = 'shelf';


  const MyShelfScreen({super.key});

  @override
  State<MyShelfScreen> createState() => _MyShelfScreenState();
}

class _MyShelfScreenState extends State<MyShelfScreen> {
  int selectedIndex = 0; // tab المختارة حاليًا

  final List<String> tabs = ["Saved list", "On borrow", "Returned"];

  @override
  void initState() {
    super.initState();
    context.read<SaveListCubit>().getSaveBooks();
    context.read<BorrowCubit>().getBorrowBooks();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: AppBar(
          backgroundColor: MyColors.whiteColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            "My Shelf",
            style: TextStyle(
              color: MyColors.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            /// -------- Tabs --------
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(tabs.length, (index) {
                final isSelected = selectedIndex == index;
                return Padding(
                  padding: EdgeInsets.only(
                    right: 5.w
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h
                      ),
                     // height: 40.h,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MyColors.primaryColor
                            : MyColors.softGreyColor,
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(
                          color: isSelected
                              ? MyColors.primaryColor
                              : MyColors.outColor,
                        )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: isSelected
                              ? MyColors.whiteColor
                              : MyColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20.h),

            /// -------- Content --------
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  _buildSavedList(),
                  _buildOnBorrowList(),
                  _buildReturnedList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // محتوى كل تاب 👇
  Widget _buildSavedList() {
    return BlocBuilder<SaveListCubit, States>(
        builder: (context,state){
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is AllSaveBookSuccessState) {
            final saved = state.favorite;
            if (saved.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/nofound.png'),
                    SizedBox(height: 10.h,),
                    Text(
                      "No saved books yet!",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: MyColors.blackColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              itemCount: saved.length,
              itemBuilder: (context, index) {
                final save = saved[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => BookDetailsScreen(bookId: save.bookId?.id ??'' ),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
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
                              child:  Image.network(save.bookId?.mainImage ??'assets/images/book.png',
                                height: 200.h,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset("assets/images/book.png", height: 180.h,);
                                },
                              ),



                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            save.bookId?.name ?? 'no name',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: MyColors.blackColor
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            save.bookId?.writer ?? 'no writer',
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
                );


              },
            );
          }
          return Container();
        }
    );



  }

  Widget _buildOnBorrowList() {
    return BlocBuilder<BorrowCubit, States>(
        builder: (context,state){
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is GetBorrowBooksSuccessState) {
            final borrow = state.borrow;
            if (borrow.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/nofound.png'),
                    SizedBox(height: 10.h,),
                    Text(
                      "No borrowed books yet!",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: MyColors.blackColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              itemCount: borrow.length,
              itemBuilder: (context, index) {
                final borrowBook = borrow[index];
                final parsedDate =
                DateTime.parse(borrowBook.createdAt!).toLocal();
                final formattedDate = DateFormat(
                  'dd/MM',
                ).format(parsedDate);

                final formattedTime = DateFormat(
                  'HH:mm',
                ).format(parsedDate);
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => OnBorrowScreen(borrowBook: borrowBook,),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
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
                              child: //buildImage(borrowBook.bookId?.mainImage)
                              Image.network(borrowBook.bookId!.mainImage ??'assets/images/book.png',
                                height: 200.h,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset("assets/images/book.png", height: 180.h,);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            borrowBook.bookId?.name ?? 'no name',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: MyColors.blackColor
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            borrowBook.bookId?.writer ??'no writer',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: MyColors.greyColor
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(
                                  color: MyColors.orangeColor, // لون الدائرة
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "On borrow (Returned in $formattedDate at $formattedTime)",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.darkOrangeColor
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                );


              },
            );
          }
          return Container();
        }
    );








  }

  Widget _buildReturnedList() {
    return BlocBuilder<BorrowCubit, States>(
        builder: (context,state){
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is GetBorrowBooksSuccessState) {
            final returned = state.returned;
            if (returned.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/nofound.png'),
                    SizedBox(height: 10.h,),
                    Text(
                      "No returned books yet!",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: MyColors.blackColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              itemCount: returned.length,
              itemBuilder: (context, index) {
                final returnedBook = returned[index];
                final parsedDate =
                DateTime.parse(returnedBook.createdAt!).toLocal();
                final formattedDate = DateFormat(
                  'dd/MM',
                ).format(parsedDate);

                final formattedTime = DateFormat(
                  'HH:mm',
                ).format(parsedDate);
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => ReturnedScreen(returnedBook: returnedBook,),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
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
                              child:  Image.network(returnedBook.bookId!.mainImage ??'assets/images/book.png',
                                height: 200.h,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset("assets/images/book.png", height: 180.h,);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            returnedBook.bookId?.name ??'',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color: MyColors.blackColor
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            returnedBook.bookId?.writer ??'',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: MyColors.greyColor
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(
                                  color: MyColors.greenColor, // لون الدائرة
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Returned",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.darkGreenColor
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                );


              },
            );
          }
          return Container();
        }
    );



  }
}
