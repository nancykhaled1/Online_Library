import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Cubit/Profile/ProfileViewModel.dart';
import '../../Cubit/States/States.dart';
import '../../Utils/MyColors.dart';
import '../../Utils/TextField.dart';
import 'ProfileScreen.dart';


class PersonalDetails extends StatefulWidget{
  static const String routeName = 'personal';

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {

  @override
  void initState() {
    super.initState();
    context.read<ProfileViewModel>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    //final viewModel = context.read<ProfileViewModel>();

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
        child: BlocBuilder<ProfileViewModel, States>(
          builder: (context, state) {
            final viewModel = context.read<ProfileViewModel>();

            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyColors.primaryColor,
                ),
              );
            }

            if (state is ErrorState) {
              return Center(
                child: Text(state.errorMessage ?? "There is an error"),
              );
            }
            return Column(
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
                  hintText: "",
                  readonly: true,
                  prefixIcon: Icons.perm_identity,
                  controller: viewModel.userNameController,
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
                  hintText: "",
                  controller: viewModel.emailController,
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
                  hintText: "",
                  controller: viewModel.phoneController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter your password';
                    }

                    return null;
                  },

                ),
                SizedBox(height: 20.h),
                buildGenderDropdown(viewModel)
              ],
            );
          },
        ),





      ),
    ));
  }

  Widget buildGenderDropdown(ProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الحقل الرئيسي
        GestureDetector(
          onTap: () {
            setState(() {
              viewModel.showDropdownlevel = !viewModel.showDropdownlevel;
            });
          },
          child: AbsorbPointer(
            child: CustomTextField(
              keyboardType: TextInputType.visiblePassword,
              label: "Gender",
              hintText: "Choose your gender",
              prefixIcon: Icons.lock_outline,
              controller: viewModel.genderController,
              suffixIcon: Icon(
                viewModel.showDropdownlevel
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down, // تغيير الأيقونة
                size: 35.sp,
                color: MyColors.primaryColor,
              ),
              readonly: true,
              validator: (text) {
                if (text == null || text.isEmpty || text.trim().isEmpty) {
                  return 'please choose your gender';
                }
                return null;
              },
            ),

          ),
        ),

        // القائمة المنسدلة
        if (viewModel.showDropdownlevel)
          Column(
            children:
            viewModel.gender.map((item) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    viewModel.genderController.text = item;
                    viewModel.showDropdownlevel = false;
                  });
                },

                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: MyColors.softGreyColor),
                    ),
                    // borderRadius: BorderRadius.circular(10.r),
                    color: MyColors.whiteColor,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/level.svg',
                        width: 15.sp,
                        height: 15.sp,
                        colorFilter: ColorFilter.mode(
                          Color(0xFF7A7A7A),
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        item,
                        style: TextStyle(
                          color: MyColors.greyColor,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}