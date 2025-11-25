import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Cubit/Auth/Login/re-passViewModel.dart';
import '../../../Cubit/States/States.dart';
import '../../../Utils/MyColors.dart';
import '../../../Utils/TextField.dart';
import '../../../Utils/dialog.dart';
import '../../Home/home.dart';


class ResetPassword extends StatefulWidget{
  static const String routeName = 'resetpass';
  final String email;
  final String code;

  const ResetPassword({
    Key? key,
    required this.email,
    required this.code,
  }) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RePasswordCubit,States>(
      listener: (context, state) {
        if (state is ErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        } else if (state is ChangePassSuccessState) {
         showOverlayMessage(context, state.response.data!.message!, isError: false);
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }

      },
    builder: (context, state) {
      final viewModel = context.read<RePasswordCubit>();
    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: SafeArea(child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          appBar: AppBar(
            backgroundColor: MyColors.whiteColor ,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: SingleChildScrollView(
            padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFF3B82F6),
                      child: Icon(Icons.menu_book_rounded,
                          color: Colors.white, size: 20),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Baca",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                SizedBox(height: 60.h),
                Text('Enter your new Password !',
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: MyColors.blackColor
                  ),
                ),
                // SizedBox(
                //   height: 8.h,
                // ),
                // Text(
                //   'Enter your email to send a code',
                //   style: TextStyle(
                //       fontSize: 14.sp,
                //       fontWeight: FontWeight.w500,
                //       color: MyColors.greyColor
                //   ),
                // ),
                SizedBox(
                  height: 40.h,
                ),
                Form(
                   key: viewModel.formKey,
                  child: Column(
                    children: [
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
                      SizedBox(height: 20.h),
                      // 🔹 rePassword field
                      CustomTextField(
                        keyboardType: TextInputType.visiblePassword,
                        label: "Password",
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


                      SizedBox(
                        height: 30.h,
                      ),
                      ElevatedButton(
                        onPressed: (){
                          final newPassword = viewModel.passwordController.text;

                          viewModel.changePassword(email: widget.email, code: widget.code, newPassword: newPassword);
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
                        // onPressed: state is LoadingState
                        //     ? null // منع الضغط أثناء التحميل
                        //     : () {
                        //   viewModel.sendEmail();
                        // },
                        // child: state is LoadingState
                        //     ? Center(
                        //   child: SizedBox(
                        //     width: 20.w,
                        //     height: 20.w,
                        //     child: CircularProgressIndicator(
                        //       strokeWidth: 2,
                        //       valueColor: AlwaysStoppedAnimation<Color>(MyColors.whiteColor),
                        //     ),
                        //   ),
                        // )
                        //   :
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Save Changes",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: MyColors.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          )
      )),
    );

     },

     );




  }
}