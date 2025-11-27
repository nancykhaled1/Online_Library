import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_library_app/Utils/MyColors.dart';
import 'package:online_library_app/View/Auth/Login/LoginScreen.dart';

import '../Auth/Register/RegisterScreen.dart';

class OnBoarding extends StatelessWidget{
  static const String routeName = 'boarding';

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/Library-bro.svg',
           height: 400,
            //  width: double.infinity,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 10.h,),

            Center(
              child: Text('Borrow library books easily and quickly!',
                textAlign: TextAlign.center,   // 🔥 يخلي التكست في النص
                style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize:28.sp ,
                color: MyColors.blackColor,

              ),
              ),
            ),
            SizedBox(height: 10.h,),
            Text('Borrow library books easily and convenienty, with quick access anytime, anywhere',
              textAlign: TextAlign.center,   // 🔥 يخلي التكست في النص
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize:14.sp ,
                  color: MyColors.greyColor
              ),
            ),
            SizedBox(height: 20.h,),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                        LoginScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
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
                    "Get started",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

            ),
            SizedBox(height: 15.h,),

            ElevatedButton(
              onPressed:(){
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                        RegisterScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.whiteColor,
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 16.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                side: BorderSide(
                  color: MyColors.outColor
                )

              ),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I’m new, sign me up",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: MyColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

            ),

          ],
        ),
      ),
    ));
  }

}