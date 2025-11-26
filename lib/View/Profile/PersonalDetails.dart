import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_library_app/View/Home/home.dart';

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
      appBar:AppBar(
      backgroundColor: MyColors.whiteColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Text(
        'Personal Details',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
          color: MyColors.blackColor,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(initialIndex: 3,),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        icon: Icon(Icons.arrow_back),
      ),

      /// 🔥 زرار Edit / Save
      actions: [
        BlocBuilder<ProfileViewModel, States>(
          builder: (context, state) {
            final viewModel = context.read<ProfileViewModel>();

            return TextButton(
              onPressed: () {
                if (!viewModel.isEditable) {
                  // ادخل وضع التعديل
                  viewModel.toggleEdit();
                } else {
                  // اعمل Update
                  viewModel.updateProfile();
                }
              },

              child: Text(
                viewModel.isEditable ? "Save" : "Edit",
                style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

            );
          },
        ),
      ],
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
                child: CircularProgressIndicator(),
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
              radius: 50.r,
              backgroundColor:
              MyColors.whiteColor,
              child: ClipOval(
                child:
                viewModel.image != null
                    ? Image.file(
                  viewModel.image!,
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                )
                    : viewModel.profileImageUrl !=
                    null &&
                    viewModel
                        .profileImageUrl!
                        .startsWith(
                      'http',
                    )
                    ? Image.network(
                  viewModel
                      .profileImageUrl!,
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                  key: UniqueKey(),
                  loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                      ) {
                    if (loadingProgress ==
                        null)
                      return child;
                    return const Center(
                      child: CircularProgressIndicator(
                        color:
                        MyColors
                            .primaryColor,
                      ),
                    );
                  },
                  errorBuilder:
                      (
                      context,
                      error,
                      stackTrace,
                      ) => Image.asset(
                    'assets/images/userProfile.png',
                    fit: BoxFit.cover,
                  ),
                )
                    : Image.asset(
                  viewModel
                      .profileImageUrl ??
                      'assets/images/userProfile.png',
                  // width: 120.w,
                  // height: 120.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
                SizedBox(height: 10.h),

                TextButton(
                  onPressed: viewModel.isEditable ? () {
                    viewModel.pickProfileImage();
                  } : null,
                  child: viewModel.isEditable ? Text(
                    'change photo profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                     color: MyColors.primaryColor
                     // color: viewModel.isEditable ? MyColors.primaryColor : Colors.grey,
                    ),
                  ) : Container(),
                ),

                SizedBox(height: 10.h),


                CustomTextField(
                  keyboardType: TextInputType.text,
                  label: "Full Name",
                  hintText: "",
                  readonly: !viewModel.isEditable,
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
                  readonly: !viewModel.isEditable,
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

                  readonly: !viewModel.isEditable,
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
                CustomTextField(
                  readonly: true,
                  label: "Gender",
                  hintText: "",
                  prefixIcon: Icons.person,
                  controller: viewModel.genderController,
                  validator: (text) {
                    if (text == null || text.isEmpty || text.trim().isEmpty) {
                      return 'please choose your gender';
                    }
                    return null;
                  },
                ),
              ],
            );
          },
        ),
      ),
    ));
  }
}