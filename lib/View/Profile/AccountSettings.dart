import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Cubit/Profile/ProfileViewModel.dart';
import '../../Utils/CommenConfirmSheet.dart';
import '../../Utils/MyColors.dart';
import '../Home/home.dart';
import 'ProfileScreen.dart';


class AccountSettings extends StatelessWidget{
  static const String routeName = 'setting';

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProfileViewModel>();

    return SafeArea(child: Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: AppBar(
        backgroundColor: MyColors.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title:  Text('Account Settings',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            color: MyColors.blackColor,
          ),
        ),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(initialIndex: 3,),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                showCommonBottomSheet(
                  context: context,
                  imagePath: 'assets/images/logoutImage.png',
                  title: 'Logout from this account?',
                  description:
                  'Are you sure you want to logout from this account? You can login again to this account!',
                  primaryButtonText: 'Yes, Logout',
                  onPrimaryPressed: () {
                    viewModel.logout(context);
                  },
                  secondaryButtonText: 'No, Cancel',
                  onSecondaryPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h
                      ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: MyColors.outColor
                  )
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                       SvgPicture.asset('assets/images/logout.svg'),
                        SizedBox(width: 10.w,),
                        Text('Logout',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: MyColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    Row(
                      children: [
                        Text('Sign out of your currently connected account \nin LendABook',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: MyColors.greyColor,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: (){
                showCommonBottomSheet(
                  context: context,
                  imagePath: 'assets/images/deleteImage.png',
                  title: 'Delete this account?',
                  description:
                  'You sure you want to delete this account? You will not be able to be logged back in to this account!',
                  primaryButtonText: 'Yes, Delete',
                  onPrimaryPressed: () async {
                    await context.read<ProfileViewModel>().deleteProfile(context);

                  },
                  secondaryButtonText: 'No, Cancel',
                  onSecondaryPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                        color: MyColors.outColor
                    )
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/trash.svg'),
                        SizedBox(width: 10.w,),
                        Text('Delete account',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: MyColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    Row(
                      children: [
                        Text('Permanently and irreversibly deleting your \naccount ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: MyColors.greyColor,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}