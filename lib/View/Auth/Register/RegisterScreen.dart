import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Cubit/Auth/Register/GoogleViewModel.dart';
import '../../../Cubit/Auth/Register/RegisterViewModel.dart';
import '../../../Cubit/States/States.dart';
import '../../../Utils/MyColors.dart';
import '../../../Utils/SuccessSheet.dart';
import '../../../Utils/TextField.dart';
import '../../../Utils/dialog.dart';
import '../../Home/home.dart';
import '../Login/LoginScreen.dart';
import 'VerifyEmail.dart';



class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterCubit registerCubit;

  @override
  void initState() {
    super.initState();
    registerCubit = context.read<RegisterCubit>();
  }

  // @override
  // void dispose() {
  //   registerCubit.clearForm();
  //   super.dispose();
  // }


  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return BlocConsumer<RegisterCubit, States>(
      listener: (context, state) {
        if (state is ErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        }

        else if (state is RegisterSuccessState) {
          showOverlayMessage(
            context,
            state.response.data!.message!,
            isError: false,
          );

          final userId = state.response.data?.userId; // استبدل بالاسم المناسب
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyEmail(userId: userId ??''),
            ),
          );

        }
      },
      builder: (context, state) {
        final viewModel = context.read<RegisterCubit>();
        return WillPopScope(
          onWillPop: () async {
            // هنا بتتحكمى هل ترجعى ولا لا
            return false; // ❌ مش هيرجع
            // return true;  ✅ هيرجع
          },
          child: Scaffold(
            backgroundColor: MyColors.whiteColor,
            body: SafeArea(
              child: SingleChildScrollView(
                padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Logo & App name
                    Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 150.w,
                        height: 150.h,
                      ),
                    ),





                    // 🔹 Welcome text
                    Text(
                      "Create your account",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: MyColors.blackColor
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Create a new account so you can reads lots of interesting books!",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: MyColors.greyColor
                      ),
                    ),

                    SizedBox(height: 40.h),

                    Form(
                      key:_formKey,
                      child: Column(
                          children: [
                            // name
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              label: "Name",
                              hintText: "your name",
                              prefixIcon: Icons.person,
                              controller: viewModel.nameController,
                              validator: (text) {
                                if (text!.isEmpty || text.trim().isEmpty) {
                                  return 'enter your name';
                                }
                                return null;
                              },

                            ),
                            SizedBox(height: 20.h),
                            // email
                            CustomTextField(
                              keyboardType: TextInputType.emailAddress,
                              label: "Email",
                              hintText: "youremail@mail.com",
                              prefixIcon: Icons.email_outlined,
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
                              keyboardType: TextInputType.phone,
                              label: "Phone",
                              hintText: "Input your phone",
                              prefixIcon: Icons.phone_android,
                              controller: viewModel.phoneController,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Please enter your password';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),

                            //  Password field
                            CustomTextField(
                              keyboardType: TextInputType.visiblePassword,
                              label: "Password",
                              hintText: "Input your password",
                              prefixIcon: Icons.lock_outline,
                              isobscure: viewModel.isPasswordVisible,
                              controller: viewModel.passwordController,
                              validator: (text) {
                                if (text!.isEmpty || text.trim().isEmpty) {
                                  return 'enter your password';
                                }
                                if (text.length < 6) {
                                  return 'must be more than 6 number';
                                }
                                return null;
                              },
                              suffixIcon: Icon(
                                viewModel.isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18.sp,
                                color: MyColors.blackColor,
                              ),
                              suffixIconFunction: () {
                                setState(() {
                                  viewModel.isPasswordVisible = !viewModel.isPasswordVisible;
                                });
                              },
                            ),
                            SizedBox(height: 20.h),
                            //  rePassword field
                            CustomTextField(
                              keyboardType: TextInputType.visiblePassword,
                              label: "Confirmation Password",
                              hintText: "Confirm your password",
                              prefixIcon: Icons.lock_outline,
                              isobscure: viewModel.isRePasswordVisible,
                              controller: viewModel.rePasswordController,
                              validator: (text) {
                                if (text == null || text.isEmpty)
                                  return 'Please enter your password';
                                if (text != viewModel.passwordController.text)
                                  return 'Password didn’t match!';
                                return null;
                              },
                              suffixIcon: Icon(
                                viewModel.isRePasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18.sp,
                                color: MyColors.blackColor,
                              ),
                              suffixIconFunction: () {
                                setState(() {
                                  viewModel.isRePasswordVisible = !viewModel.isRePasswordVisible;
                                });
                              },
                            ),
                            SizedBox(height: 20.h),

                            buildGenderDropdown(viewModel),

                            SizedBox(height: 30.h),





                            // 🔹 Login button
                            ElevatedButton(
                              onPressed: state is LoadingState
                                  ? null
                                  : () {
                                if (_formKey.currentState!.validate()) {
                                  viewModel.register();
                                } else {
                                  showOverlayMessage(context, "Please complete the form", isError: true);
                                }
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
                              // state is LoadingState
                              //     ? SizedBox(
                              //   width: 50.w,
                              //   height: 20.w,
                              //   child: CircularProgressIndicator(
                              //     strokeWidth: 2,
                              //     valueColor:
                              //     AlwaysStoppedAnimation<Color>(
                              //       MyColors.whiteColor,
                              //     ),
                              //   ),
                              // )
                              //     :
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),



                            ),
                          ]
                      ),
                    ),
                    // 🔹 Email field


                    SizedBox(height: 16.h),

                    // 🔹 Google login button
                    BlocConsumer<GoogleCubit, States>(
                      listener: (context, state)  async {
                        if (state is LoadingState) {
                          showOverlayMessage(context, "Loading", isError: false);
                        } else if (state is ErrorState) {
                          state.errorMessage;
                          showOverlayMessage(context, state.errorMessage!, isError: true);
                        } else if (state is GoogleSuccessState) {
                          showOverlayMessage(
                              context, "Successfully login", isError: false);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is LoadingState
                              ? null
                              : () async {
                            context.read<GoogleCubit>().signInWithGoogle(

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
                                  color: MyColors.greyColor
                              )
                            // elevation: 5,
                            // shadowColor: MyColors.shadGreyColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/Google.svg'),
                              SizedBox(width: 10.w),
                              Text(
                                "Login with Google",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: MyColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 50.h),

                    // 🔹 Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<RegisterCubit>().clearForm();

                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: Text(
                            "Login here",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.w500

                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildGenderDropdown(RegisterCubit viewModel) {
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
              prefixIcon: Icons.person,
              controller: viewModel.genderController,
              suffixIcon: Icon(
                viewModel.showDropdownlevel
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down, // تغيير الأيقونة
                size: 35.sp,
                color: MyColors.blackColor,
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
            viewModel.genders.map((item) {
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
                      // SvgPicture.asset(
                      //   'assets/images/level.svg',
                      //   width: 15.sp,
                      //   height: 15.sp,
                      //   colorFilter: ColorFilter.mode(
                      //     Color(0xFF7A7A7A),
                      //     BlendMode.srcIn,
                      //   ),
                      // ),
                      SizedBox(width: 20.w),
                      Text(
                        item,
                        style: TextStyle(
                          color: MyColors.greyColor,
                          fontFamily: "Noto Kufi Arabic",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
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
