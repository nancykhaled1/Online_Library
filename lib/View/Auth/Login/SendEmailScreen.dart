import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../Cubit/Auth/Login/forget_passViewModel.dart';
import '../../../Cubit/States/States.dart';
import '../../../Utils/MyColors.dart';
import '../../../Utils/TextField.dart';
import '../../../Utils/dialog.dart';
import 'SendCode.dart';

class SendEmailScreen extends StatelessWidget{
  static const String routeName = 'sendEmail';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPassScreenCubit,States>(
      listener: (context, state) {
        if (state is ErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        } else if (state is SendEmailSuccessState) {
          showOverlayMessage(context, state.response.data!.message!, isError: false);
          final email = context.read<ForgetPassScreenCubit>().emailController.text;
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => SendCode(email: email),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
     builder: (context, state) {
       final viewModel = context.read<ForgetPassScreenCubit>();
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
                    Text('Forget your Password ?',
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: MyColors.blackColor
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Enter your email to send a code',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: MyColors.greyColor
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Form(
                      key: viewModel.formKey,
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
                          SizedBox(
                            height: 30.h,
                          ),
                          ElevatedButton(
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
                            onPressed: state is LoadingState
                                ? null // منع الضغط أثناء التحميل
                                : () {
                              viewModel.sendEmail();
                            },
                            child: state is LoadingState
                                ? Center(
                              child: SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(MyColors.whiteColor),
                                ),
                              ),
                            )
                              :
                              Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Send Email",
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