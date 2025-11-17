import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/MyColors.dart';
import '../../Utils/TextField.dart';
import 'ProfileScreen.dart';


class PersonalDetails extends StatelessWidget{
  static const String routeName = 'personal';

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: AppBar(
        backgroundColor: MyColors.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title:  Text('Personal Details',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            color: MyColors.blackColor,
          ),
        ),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ProfileScreen(),
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
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: MyColors.primaryColor,
             // child: Image.asset('assets/images/book.png'),
            ),
            SizedBox(height: 10.h),

            TextButton(
              onPressed: (){

              },
              child: Text('change photo profile',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: MyColors.primaryColor,
            ),
            ),
            ),

            SizedBox(height: 10.h),


            CustomTextField(
              keyboardType: TextInputType.text,
              label: "Full Name",
              hintText: "nancy",
              readonly: true,
              prefixIcon: Icons.perm_identity,
              controller: null,
              validator: (text) {
                if (text!.isEmpty || text.trim().isEmpty) {
                  return 'enter your name';
                }
                return null;
              },

            ),
            SizedBox(height: 20.h),
            CustomTextField(
              readonly: true,
              keyboardType: TextInputType.emailAddress,
              label: "Email",
              prefixIcon: Icons.email_outlined,
              hintText: "youremail@mail.com",
              controller: null,
              validator: (text) {
                if (text!.isEmpty || text.trim().isEmpty) {
                  return 'enter your correct email';
                }
                bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                ).hasMatch(text);
                if (!emailValid) {
                  return 'enter your correct email';
                }
                return null;
              },

            ),
            SizedBox(height: 20.h),
            CustomTextField(
              prefixIcon: Icons.phone_android,

              readonly: true,
              keyboardType: TextInputType.phone,
              label: "Phone",
              hintText: "01210047728",
              controller: null,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Please enter your password';
                }

                return null;
              },

            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    ));
  }

}