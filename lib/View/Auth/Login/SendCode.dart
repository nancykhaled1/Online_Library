

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_library_app/View/Auth/Login/LoginScreen.dart';

import '../../../Cubit/Auth/Login/SendCodeViewModel.dart';
import '../../../Cubit/States/States.dart';
import '../../../Utils/MyColors.dart';
import '../../../Utils/dialog.dart';
import 'ResetPassword.dart';

class SendCode extends StatefulWidget {
  static const String routeName = 'code';
  final String email;
  const SendCode({Key? key, required this.email}) : super(key: key);

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
   String? code;
   // late SendCodeCubit cubit;
   //
   //
   //
   // @override
   // void dispose() {
   //   cubit.clear();
   //   super.dispose();
   // }


  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SendCodeCubit>();

    return BlocConsumer<SendCodeCubit, States>(
      listener: (context, state) {
        if (state is ErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);

        }
        if (state is ResetPassSuccessState) {
          showOverlayMessage(context, state.response.data!.message!, isError: false);

          final code = context.read<SendCodeCubit>().getEnteredCode();
          print("CODE ENTERED: $code");
          // print("✅ Entered Code: $enteredCode");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPassword(
                  email : widget.email,
                  code : code
              ),
            ),
          );
        }

      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: MyColors.whiteColor,
            appBar: AppBar(
              backgroundColor: MyColors.whiteColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: IconButton(
                onPressed: () {
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
                icon: Icon(Icons.arrow_back),
              ),
            ),
            body: SingleChildScrollView(
              padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 0.h),
              child: WillPopScope(
                onWillPop: () async {
                  // هنا بتتحكمى هل ترجعى ولا لا
                  return false; // ❌ مش هيرجع
                  // return true;  ✅ هيرجع
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 150.w,
                        height: 150.h,
                      ),
                    ),


                    // Center(
                    //     child: SvgPicture.asset('assets/images/code-pass.svg')),
                    Text(
                      'Reset a password',
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: MyColors.blackColor
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'we have send a code to your email at ${widget.email} ',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: MyColors.greyColor
                      ),
                    ),
                    SizedBox(height: 40.h),
                    /// Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: SizedBox(
                            width: 47.w,
                            height: 45.h,
                            child: TextField(
                              controller: viewModel.controllers[index],
                              focusNode: viewModel.focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: viewModel.controllers[index].text.isNotEmpty
                                        ? MyColors.primaryColor
                                        :
                                    MyColors.greyColor,
                                   // color: MyColors.outColor,
                                    width: 1.w,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.inputColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  if (index < 5) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                } else {
                                  if (index > 0) {
                                    FocusScope.of(context).previousFocus();
                                  }
                                }
                                 viewModel.checkCodeCompletion();
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Have a problem ? ',
                    //       style: TextStyle(
                    //           fontSize: 14.sp,
                    //           fontWeight: FontWeight.w500,
                    //           color: MyColors.greyColor
                    //       ),
                    //     ),
                    //     Text(
                    //       '44:4',
                    //       style: TextStyle(
                    //           fontSize: 14.sp,
                    //           fontWeight: FontWeight.w500,
                    //           color: MyColors.primaryColor
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 50.h),

                    /// Verify Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(

                        onPressed: (state is! LoadingState && viewModel.isCodeComplete)
                            ? () {
                          final code = viewModel.getEnteredCode();
                          viewModel.resetPassword(email: widget.email, code: code);


                        }
                            : null,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: viewModel.isCodeComplete
                              ? MyColors.primaryColor
                              : MyColors.greyColor,
                          foregroundColor: MyColors.whiteColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 16.w,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                        ),
                        child: (state is LoadingState)
                            ? SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                          :
                        Text(
                          "Send",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Noto Kufi Arabic",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )



                  ],
                ),
              ),
            ),
          ),
        );
      },
    );



  }
}