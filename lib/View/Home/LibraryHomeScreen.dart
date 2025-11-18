import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_library_app/View/Home/CategoryDetails.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Cubit/Home/BookViewModel.dart';
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
  TabController? _tabController;
  String? currentSelectedCategoryId;

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

    /// 🚀 أول استدعاء للـ Home Data
    context.read<HomeScreenCubit>().loadHomeData();
  }

  void _setupTabListener() {
    _tabController?.addListener(() {
      if (_tabController!.indexIsChanging) return;

      final homeState = context.read<HomeScreenCubit>().state;

      if (homeState is HomeDataSuccessState) {
        final selectedParent = homeState.parents[_tabController!.index];
        final parentId = selectedParent.id!;

        context.read<CategoryCubit>().getCategoryById(parentId);

        setState(() {
          currentSelectedCategoryId = null; // Reset عند تغيير Parent
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<HomeScreenCubit, States>(
          listener: (context, state) {
            if (state is HomeDataSuccessState) {
              _tabController ??= TabController(
                length: state.parents.length,
                vsync: this,
              );

              _setupTabListener();

              /// 🚀 أول Parent
              final firstParentId = state.parents[0].id!;
              context.read<CategoryCubit>().getCategoryById(firstParentId);
            }
          },
          child: BlocBuilder<HomeScreenCubit, States>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is HomeDataSuccessState) {
                final parents = state.parents;

                if (_tabController == null) return SizedBox();

                String currentTab = parents[_tabController!.index].name ?? '';

                return SingleChildScrollView(
                  padding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ---------- HEADER + TABS ----------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              tabs: parents
                                  .map((p) => Tab(text: p.name ?? ''))
                                  .toList(),
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

                      /// ---------- SEARCH ----------
                      TextField(
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

                      /// ---------- SLIDER ----------
                      SizedBox(
                        height: 150.h,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(8.r),
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

                      SizedBox(height: 25.h),

                      /// ---------- CATEGORIES ----------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Explore by categories",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
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

                      BlocConsumer<CategoryCubit, States>(
                        listener: (context, state) {
                          if (state is CategoryByIdSuccessState) {
                            final children = state.children;

                            if (children.isNotEmpty &&
                                currentSelectedCategoryId == null) {
                              currentSelectedCategoryId = children[0].id!;
                              context
                                  .read<BookCubit>()
                                  .getBookByCategoryId(children[0].id!);
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is BookLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (state is CategoryByIdSuccessState) {
                            final category = state.children;

                            if(category.isEmpty){

                              return Center(
                                child: Text('no books in this category',
                                  style: TextStyle(color: MyColors.primaryColor,
                                    fontSize: 16.sp,
                                  ),),
                              );
                            }

                            return SizedBox(
                              height: 80.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: category.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(width: 10.w),
                                itemBuilder: (context, index) {
                                  final cat = category[index];
                                  final isSelected =
                                      currentSelectedCategoryId == cat.id;



                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentSelectedCategoryId = cat.id!;
                                      });

                                      context
                                          .read<BookCubit>()
                                          .getBookByCategoryId(cat.id!);
                                    },
                                    child: Container(
                                      width: 110.w,
                                      padding: EdgeInsets.all(14.r),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(14.r),
                                        border: Border.all(
                                          color: isSelected
                                              ? MyColors.primaryColor
                                              : MyColors.outColor,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          cat.name ?? '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }

                          return SizedBox();
                        },
                      ),

                      SizedBox(height: 25.h),

                      /// ---------- BOOK LIST ----------
                      Text(
                        "$currentTab just for you!",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      BlocBuilder<BookCubit, States>(
                        builder: (context, state) {
                          if (state is BookLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          }


                          if (state is BookByCategoryIdSuccessState) {
                            final books = state.book;
                            if(books.isEmpty){

                              return Center(
                                child: Text('no books in this category',
                                  style: TextStyle(color: MyColors.primaryColor,
                                  fontSize: 16.sp,
                                  ),),
                              );
                            }

                            return SizedBox(
                              height: 250.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: books.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final book = books[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => BookDetailsScreen(
                                            bookId: book.id!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 160.w,
                                          height: 180.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(12.r),
                                            border: Border.all(
                                                color: MyColors.outColor),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(12.r),
                                            child: Image.network(
                                              book.mainImage ?? '',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.r),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                book.name ?? '',
                                                maxLines: 2,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                book.publisher ?? '',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
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

                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                );
              }

              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
