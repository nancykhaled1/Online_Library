import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_library_app/View/Search/SearchScreen.dart';

import '../../Utils/MyColors.dart';
import '../Library/LibraryScreen.dart';
import '../MyShelf/MyShelfScreen.dart';
import '../Profile/ProfileScreen.dart';
import 'LibraryHomeScreen.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';

  final int initialIndex;
  final String? categoryId;
  final String? categoryName;
  const HomeScreen({Key? key, this.initialIndex = 0,this.categoryId,this.categoryName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    LibraryHomeScreen(),
    LibraryScreen(),
    MyShelfScreen(),
    ProfileScreen()
  ];

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: Container(

        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(

          iconSize: 25.sp,
          currentIndex: _currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: MyColors.primaryColor,
          unselectedItemColor: MyColors.greyColor,
          selectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/home.svg',
              width: 20.w,
              height: 20.h,
              color:  _currentIndex == 0
                    ? MyColors.primaryColor
                    : MyColors.greyColor,
              ),
              // icon: Icon(Icons.home_outlined,
              // color: _currentIndex == 0
              //     ? MyColors.primaryColor
              //     : MyColors.greyColor,
              // ),
              label: 'Home',

            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/bookcase.svg',
                width: 20.w,
                height: 20.h,
                color:  _currentIndex == 1
                    ? MyColors.primaryColor
                    : MyColors.greyColor,
              ),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/my-folder.svg',
                width: 20.w,
                height: 20.h,
                color:  _currentIndex == 2
                    ? MyColors.primaryColor
                    : MyColors.greyColor,
              ),
              label: 'My shelf',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/profile.svg',
                width: 20.w,
                height: 20.h,
                color:  _currentIndex == 3
                    ? MyColors.primaryColor
                    : MyColors.greyColor,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
