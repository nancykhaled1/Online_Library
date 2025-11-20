import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Cubit/Search/SearchScreenViewModel.dart';
import '../../Cubit/States/States.dart';
import '../../Utils/MyColors.dart';
import '../Home/home.dart';
import '../Library/BookDetails.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Column(
            children: [
              /// ---------- SEARCH FIELD ----------
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                              HomeScreen(initialIndex: 1,),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Tap to search...",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: MyColors.greyColor,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.sp),
                          child: SvgPicture.asset('assets/images/Icon Left.svg'),
                        ),
                        filled: true,
                        fillColor: MyColors.softGreyColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            context.read<SearchScreenCubit>().clearSearchResults();
                          } else {
                            context.read<SearchScreenCubit>().searchBooks(value);
                          }
                        }

                    ),
                  ),
                ],
              ),

              SizedBox(height: 25.h),

              BlocBuilder<SearchScreenCubit, States>(
                builder: (context, state) {
                  if (state is SearchBooksSuccessState && state.search.isNotEmpty) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your recent search",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: MyColors.blackColor,
                          ),
                        ),
                        SizedBox(width: 25.w),
                        GestureDetector(
                          onTap: () {
                            context.read<SearchScreenCubit>().clearSearchResults();
                            _searchController.clear();
                          },
                          child: Text(
                            "clear",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: MyColors.greyColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  /// لو مفيش نتائج → متعرضوش خالص
                  return SizedBox.shrink();
                },
              ),


              SizedBox(height: 25.h),

              /// ---------- SEARCH RESULTS ----------
              Expanded(
                child: BlocBuilder<SearchScreenCubit, States>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (state is SearchBooksSuccessState) {
                      final books = state.search;

                      if (books.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/nofound.png'),
                            SizedBox(width: 5.w,),
                            Text(
                              "No matches found",
                              style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              "There is no matches data that you search\n Try using another keyword.",
                              style: TextStyle(
                                color: MyColors.greyColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        );
                      }

                      return ListView.separated(
                        itemCount: books.length,
                        separatorBuilder: (_, __) => SizedBox(height: 20.h),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    FadeInImage(
                                      placeholder: AssetImage("assets/images/nofound.png"),
                                      image: NetworkImage(book.mainImage ?? ""),
                                      height: 90.h,
                                      width: 60.w,
                                      imageErrorBuilder: (context, error, stackTrace) {
                                        return Image.asset("assets/images/nofound.png");
                                      },
                                    ),

                                    // Image.network(
                                    //   book.mainImage ?? '',
                                    //   height: 90.h,
                                    //   width: 60.w,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    SizedBox(width: 20.w),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book.name ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          book.publisher ?? '',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: MyColors.greyColor,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/images/star.svg'),
                                            SizedBox(width: 4.w),
                                            Text(
                                              '${book.averageRating ??0}',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: MyColors.greyColor,
                                              ),
                                            ),
                                            SizedBox(width: 25.w),
                                            Text(
                                              "${book.numberInStock} book available",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: MyColors.primaryColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }

                    if (state is ErrorState) {
                      return Center(
                        child: Text(
                          state.errorMessage??'error',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/search.svg',height: 150.h,),
                        SizedBox(height: 10.w,),
                        Text(
                          "Start typing to search...",
                          style: TextStyle(
                              color: MyColors.greyColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
