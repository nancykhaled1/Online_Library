import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Utils/MyColors.dart';
import 'AccountSettings.dart';
import 'PersonalDetails.dart';


class ProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile',
              style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: MyColors.blackColor
              ),
            ),
            SizedBox(height: 25.h,),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: MyColors.primaryColor,
                 // child: Image.asset('assets/images/book.png'),
                ),
                SizedBox(width: 10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('nancy khaled',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: MyColors.blackColor
                    ),
                    ),
                    SizedBox(height: 5.h,),
                    Text('nancykhaled@gmail.com',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: MyColors.greyColor
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 25.h,),
            Text('Account',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: MyColors.blackColor
              ),
            ),
            SizedBox(height: 10.h,),

            Padding(
              padding:  EdgeInsets.symmetric(
                  vertical: 10.h
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/profile.svg',
                  width: 20.w,
                    height: 17.h,
                  ),
                  SizedBox(width: 10.h,),
                  Text('Personal details',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.blackColor
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => PersonalDetails(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: Icon(Icons.arrow_forward_ios_rounded))

                ],
              ),
            ),
            Divider(
          color: MyColors.outColor,
          thickness: 1,
          height: 16.h, // المسافة الرأسية بين العناصر
          indent: 20.w, // بداية الخط من الشمال
          endIndent: 10.w, // نهاية الخط من اليمين
        ),
            Padding(
              padding:  EdgeInsets.symmetric(
                  vertical: 10.h
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/notification-bing.svg'),
                  SizedBox(width: 10.h,),
                  Text('Notifications',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.blackColor
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded)

                ],
              ),
            ),
            Divider(
              color: MyColors.outColor,
              thickness: 1,
              height: 16.h, // المسافة الرأسية بين العناصر
              indent: 20.w, // بداية الخط من الشمال
              endIndent: 10.w, // نهاية الخط من اليمين
            ),
            Padding(
              padding:  EdgeInsets.symmetric(
                  vertical: 10.h
              ),
              child: Row(
                children: [
                  Icon(Icons.settings),
                 // SvgPicture.asset('assets/image/profile.svg'),
                  SizedBox(width: 10.h,),
                  Text('Account settings',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.blackColor
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => AccountSettings(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: Icon(Icons.arrow_forward_ios_rounded))

                ],
              ),
            ),
            Divider(
              color: MyColors.outColor,
              thickness: 1,
              height: 16.h, // المسافة الرأسية بين العناصر
              indent: 20.w, // بداية الخط من الشمال
              endIndent: 10.w, // نهاية الخط من اليمين
            ),
            Padding(
              padding:  EdgeInsets.symmetric(
                vertical: 10.h
              ),
              child: Row(
                children: [
                  Icon(Icons.text_snippet_outlined),
                  //SvgPicture.asset('assets/image/profile.svg'),
                  SizedBox(width: 10.h,),
                  Text('Policies & Terms',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.blackColor
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded)

                ],
              ),
            ),
            Divider(
              color: MyColors.outColor,
              thickness: 1,
              height: 16.h, // المسافة الرأسية بين العناصر
              indent: 20.w, // بداية الخط من الشمال
              endIndent: 10.w, // نهاية الخط من اليمين
            ),




          ],
        ),
      ),
    ));
  }

}