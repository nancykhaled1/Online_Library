import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Cubit/Home/HomeScreenViewModel.dart';
import '../../Cubit/States/States.dart';
import '../../Utils/MyColors.dart';
import '../Search/SearchScreen.dart';
import 'BookDetails.dart';

class LibraryScreen extends StatefulWidget{
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, States>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        else if (state is HomeDataSuccessState) {
          final books = state.books;
          return SafeArea(child: Scaffold(
            backgroundColor: MyColors.whiteColor,

            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 14.w,vertical: 10.h),
              child: Column(
                children: [
                  TextField(
                    readOnly: true, // ده مهم عشان ميقدرش يكتب هنا
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Tap to search...",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: MyColors.greyColor,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.sp),
                        child: SvgPicture.asset(
                          'assets/images/Icon Left.svg',
                        ),
                      ),
                      filled: true,
                      fillColor: MyColors.softGreyColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 25.h),

                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      itemCount: books.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // عدد الأعمدة في الصف الواحد
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 0.5// نسبة العرض للطول (تقدري تعدليها)
                      ),
                      itemBuilder: (context, index) {
                        var book = books[index];
                        if(books.isEmpty){

                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/nofound.png',height: 150,),
                                SizedBox(width: 5.w,),
                                Text(
                                  "No books yet!",
                                  style: TextStyle(
                                      color: MyColors.greyColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => BookDetailsScreen(bookId: book.id!),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );                    },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 160.w,
                                height: 180.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                      color: MyColors.outColor
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5.r),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(12.r)),
                                    child: Image.network(
                                      book.mainImage ??'',
                                      // height: 185.h,
                                      //width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.name ??'',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          color: MyColors.blackColor),

                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      book.publisher ??'',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: MyColors.greyColor),

                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )

                ],
              ),
            ),
          ));
        }
        else if (state is ErrorState) {
          final error = state.errorMessage;

          if (error == "No Internet Connection") {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    "assets/images/noconnection.svg", // 🖼️ ضيفي صورة عندك
                    width: 200,
                    height: 200,
                  ),
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

        else {
          return Container();
        }
      },
    );



  }
}