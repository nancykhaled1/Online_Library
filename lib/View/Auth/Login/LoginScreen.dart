import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Cubit/Auth/Login/LoginScreenViewModel.dart';
import '../../../Cubit/Auth/Register/GoogleViewModel.dart';
import '../../../Cubit/States/States.dart';
import '../../../Utils/MyColors.dart';
import '../../../Utils/TextField.dart';
import '../../../Utils/dialog.dart';
import '../../Home/home.dart';
import '../Register/RegisterScreen.dart';
import 'SendEmailScreen.dart';




class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginScreenCubit loginCubit;

  @override
  void initState() {
    super.initState();
    loginCubit = context.read<LoginScreenCubit>();
  }

  // @override
  // void dispose() {
  //   loginCubit.clearForm();
  //   super.dispose();
  // }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenCubit,States>(
      listener: (context, state) async {
        if (state is ErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        }
        else if (state is LoginSuccessState) {
          showOverlayMessage(context, state.response.data!.message!, isError: false);
          context.read<LoginScreenCubit>().clearForm();

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>  HomeScreen(),
            ),
          );

        }
      },
      builder: (context, state) {
        final viewModel = context.read<LoginScreenCubit>();
        return Scaffold(
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

                //  SizedBox(height: 30.h),



                  // 🔹 Welcome text
                  Text(
                    "Welcome back!",
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: MyColors.blackColor
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "You can log into your account first to read many interesting books!",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: MyColors.greyColor
                    ),
                  ),

                  SizedBox(height: 30.h),

                  Form(
                    key: _formKey,
                    child: Column(
                        children: [
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

                          // 🔹 Password field
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

                          SizedBox(height: 30.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forgot your password?",
                                style: TextStyle(
                                  color: MyColors.greyColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 5.w),

                              GestureDetector(
                                onTap: () {
                                  context.read<LoginScreenCubit>().clearForm();

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SendEmailScreen(),
                                    ),
                                  );
                                },
                                child:  Text(
                                  "Reset here",
                                  style: TextStyle(
                                    color: MyColors.primaryColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,

                                  ),
                                ),
                              ),
                            ],
                          ),


                          SizedBox(height: 20.h),

                          // 🔹 Login button
                          ElevatedButton(
                            onPressed: state is LoadingState
                                ? null
                                : () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.login();
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
                            //   width: 20.w,
                            //   height: 20.w,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       CircularProgressIndicator(
                            //         strokeWidth: 2,
                            //         valueColor:
                            //         AlwaysStoppedAnimation<Color>(
                            //           MyColors.whiteColor,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                            //     :
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Login",
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HomeScreen()),
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
                      Text("Don’t have an account? ",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<LoginScreenCubit>().clearForm();

                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => RegisterScreen(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                        child: Text(
                          "Register here",
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
        );

      },

    );




  }
}
