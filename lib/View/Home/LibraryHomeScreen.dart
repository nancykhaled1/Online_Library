import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_library_app/View/Home/CategoryDetails.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Cubit/Home/CategoryViewModel.dart';
import '../../Cubit/Home/HomeScreenViewModel.dart';
import '../../Cubit/States/States.dart';
import '../../Utils/MyColors.dart';
import '../Library/BookDetails.dart';

class LibraryHomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const LibraryHomeScreen({super.key});

  @override
  State<LibraryHomeScreen> createState() => _LibraryHomeScreenState();
}

class _LibraryHomeScreenState extends State<LibraryHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final PageController pageController = PageController();

  final List<String> images = [
    'assets/images/slider2.svg',
    'assets/images/slider2.svg',
    'assets/images/slider3.svg',
  ];

  final List<String> sentence = [
    'Explore the world \nthrough book',
    'Explore the world \nthrough book',
    'Explore the world \nthrough book',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    context.read<HomeScreenCubit>().loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    String currentTab = ['Books', 'Novel', 'Comic'][_tabController.index];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: BlocBuilder<HomeScreenCubit, States>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              else if (state is HomeDataSuccessState) {
                final categories = state.categories;

                final books =
                    state.books
                        .where(
                          (book) =>
                              (book.condition ?? '').toLowerCase() == 'new',
                        )
                        .toList();

                if (books.isEmpty) {
                  return Center(child: Text("No new books available."));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Header row (اسم التطبيق + التابات + نوتيفيكيشن)
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
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            // padding: EdgeInsets.only(left: 20.w),
                            labelPadding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                            ),
                            tabs: const [
                              Tab(text: "Books"),
                              Tab(text: "Novel"),
                              Tab(text: "Comic"),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/images/notification-bing.svg',
                          height: 20.h,
                          width: 25.w,
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // 🔹 Search bar
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Tab to search...",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: MyColors.greyColor,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.sp),
                          child: SvgPicture.asset(
                            'assets/images/Icon Left.svg',
                            height: 15.h,
                            width: 15.w,
                          ),
                        ),
                        filled: true,
                        fillColor: MyColors.softGreyColor,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 16.w,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: BorderSide(
                            color: MyColors.outColor,
                            width: 1.5,
                          ),
                        ),

                        // ✅ ده البوردر لما تضغطي على الفيلد
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: BorderSide(
                            color: MyColors.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 25.h),

                    /// ---------- Book Image Slider ----------
                    SizedBox(
                      height: 150.h,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: MyColors.dividerColor,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: Text(
                                    sentence[index],
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.blackColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SvgPicture.asset(images[index]),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: images.length,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: MyColors.primaryColor,
                          dotColor: MyColors.outColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // 🔹 Categories
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Explore by categories",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: MyColors.blackColor,
                          ),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: MyColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 80.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => SizedBox(width: 10.w),
                        itemBuilder: (context, index) {
                          var cat = categories[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigator.of(context).pushReplacement(
                              //   PageRouteBuilder(
                              //     pageBuilder:
                              //         (
                              //           context,
                              //           animation,
                              //           secondaryAnimation,
                              //         ) => CategoryDetailsScreen(
                              //           categoryId: cat.id!,
                              //         ),
                              //     transitionDuration: Duration.zero,
                              //     reverseTransitionDuration: Duration.zero,
                              //   ),
                              // );

                              final selectedCategoryId = cat.id!;
                              // استدعاء الداتا حسب الكاتيجوري
                              //selectedCategoryId = cat.id!;
                              context.read<CategoryCubit>().getBookByCategoryId(selectedCategoryId);
                              setState(() {}); // عشان يظهر highlight للكاتيجوري المحدد مثلاً
                          },
                            child: Container(
                              width: 110.w,
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.h,
                                vertical: 14.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(color: MyColors.outColor),
                              ),
                              child: Center(
                                child: Text(
                                  cat.name ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: MyColors.blackColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 25.h),

                    // 🔹 Book list
                    Text(
                      "$currentTab just for you!",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: MyColors.blackColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    BlocBuilder<CategoryCubit, States>(
                      builder: (context, state) {
                        if (state is BookLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        else if (state is BookByCategoryIdSuccessState) {
                          final books = state.book;

                          // final books =
                          // state.book
                          //     .where(
                          //       (book) =>
                          //   (book.condition ?? '').toLowerCase() == 'new',
                          // )
                          //     .toList();
                          //
                          // if (books.isEmpty) {
                          //   return Center(child: Text("No new books available."));
                          // }
                          return SizedBox(
                            height: 250.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemCount: books.books!.length,
                              itemBuilder: (context, index) {
                                var book = books.books?[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            ) => BookDetailsScreen(bookId: book!.id!),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration: Duration.zero,
                                      ),
                                    );
                                  },
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
                                            color: MyColors.outColor,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              blurRadius: 6,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.r),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(12.r),
                                            ),
                                            child: Image.network(
                                              book?.mainImage ?? '',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              book?.name ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700,
                                                color: MyColors.blackColor,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              book?.publisher ?? '',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: MyColors.greyColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        // else if (state is ErrorState) {
                        //   return Center(child: Text(state.errorMessage ?? 'Error'));
                        // } else {
                          return Container();
                        }

                    ),

                  ],
                );
              } else if (state is ErrorState) {
                return Center(child: Text(state.errorMessage ?? 'Error'));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
