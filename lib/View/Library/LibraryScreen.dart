import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Cubit/Home/HomeScreenViewModel.dart';
import '../../Cubit/States/States.dart';
import '../../Utils/MyColors.dart';
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
   // context.read<HomeScreenCubit>().loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, States>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeDataSuccessState) {
          final books = state.books;
          return SafeArea(child: Scaffold(
            backgroundColor: Colors.white,

            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 14.w,vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const Text(
                      //   "Baca",
                      //   style: TextStyle(
                      //     fontSize: 22,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // Tabs هنا
                      Expanded(
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          indicatorColor: MyColors.blackColor,
                          dividerColor: Colors.transparent,
                          labelColor: MyColors.blackColor,
                          unselectedLabelColor: MyColors.greyColor,
                          labelStyle: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w600
                          ),
                          unselectedLabelStyle: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.normal),
                          // padding: EdgeInsets.only(left: 20.w),
                          labelPadding:
                          EdgeInsets.symmetric(horizontal: 10.w),
                          tabs: const [
                            Tab(text: "Books"),
                            Tab(text: "Novel"),
                            Tab(text: "Comic"),
                          ],
                        ),
                      ),
                      SvgPicture.asset('assets/images/notification-bing.svg',
                        height: 20.h,
                        width: 25.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

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
        } else if (state is ErrorState) {
          return Center(child: Text(state.errorMessage ?? 'Error'));
        } else {
          return Container();
        }
      },
    );



  }
}