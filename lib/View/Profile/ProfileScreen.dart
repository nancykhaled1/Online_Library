import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Cubit/Profile/ProfileViewModel.dart';
import '../../Cubit/States/States.dart';
import '../../Utils/MyColors.dart';
import 'AccountSettings.dart';
import 'PersonalDetails.dart';


class ProfileScreen extends StatefulWidget{
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileViewModel>().getProfile();
  }

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
    BlocBuilder<ProfileViewModel, States>(
    builder: (context, state) {
      final cubit = context.read<ProfileViewModel>();
      String? imageUrl = cubit.profileImageUrl;


      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ErrorState) {
        return Text(
          'please try again later',
          style: TextStyle(
            color: Colors.red,
            fontSize: 13.sp,
          ),
        );
      } else {
        return
          Row(
            children: [
            CircleAvatar(
            radius: 50.r,
            backgroundColor: MyColors.whiteColor,
            child: ClipOval(
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                "$imageUrl?v=${DateTime.now().millisecondsSinceEpoch}",
                key: UniqueKey(),
                fit: BoxFit.cover,
                width: 100.w,
                height: 100.h,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/images/userProfile.png',
                        fit: BoxFit.fill,
                        width: 100.w,
                        height: 100.h
                    ),
              )
                  : Image.asset(
                'assets/images/userProfile.png',
                fit: BoxFit.cover,
                width: 100.w,
                height: 100.h,
              ),
            ),
          ),
              SizedBox(width: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( cubit.userNameController.text.isNotEmpty
                  ? cubit.userNameController.text : ' ',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: MyColors.blackColor
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Text(cubit.emailController.text.isNotEmpty
                    ? cubit.emailController.text : '',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.greyColor
                    ),
                  ),
                ],
              )
            ],
          );
      }
    }
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