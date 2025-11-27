import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_library_app/View/Auth/Register/RegisterScreen.dart';

import '../../../Cubit/Auth/Login/forget_passViewModel.dart';
import '../../../Cubit/Auth/Register/VerifyemailViewModel.dart';
import '../../../Cubit/States/States.dart';
import '../../../Utils/MyColors.dart';
import '../../../Utils/SuccessSheet.dart';
import '../../../Utils/dialog.dart';
import '../../Home/home.dart';


class VerifyEmail extends StatefulWidget {
  static const String routeName = 'code';
  final String userId; // 👈 هنا هيجيلك من صفحة الريجيستر
  const VerifyEmail({Key? key, required this.userId}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

  int totalSeconds = 60;
  Timer? timer;
  bool canResend = false;


  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (totalSeconds == 0) {
        t.cancel();
        setState(() {
          canResend = true;   // 🔥 إظهار زر resend
        });
      } else {
        setState(() {
          totalSeconds--;
        });
      }
    });

  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int h = seconds ~/ 3600;
    int m = (seconds % 3600) ~/ 60;
    int s = seconds % 60;
    return "${h.toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<VerifyEmailCubit>();
    final reSend = context.read<ForgetPassScreenCubit>();


    return BlocConsumer<VerifyEmailCubit, States>(
      listener: (context, state) async {
        if (state is VerifyEmailSuccessState) {

          showSuccessBottomSheet(context);

          } else if (state is ErrorState) {
          showOverlayMessage(context, state.errorMessage!, isError: true);
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
                          RegisterScreen(),
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

                    Text(
                      'Verification',
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: MyColors.blackColor
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'we have send a verify code to your email',
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
                                        ? MyColors.inputColor
                                        :
                                    MyColors.greyColor,
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
                    //         fontSize: 14.sp,
                    //         fontWeight: FontWeight.w500,
                    //         color: MyColors.greyColor,
                    //       ),
                    //     ),
                    //
                    //     /// لو الوقت لسه شغال → اعرض العداد
                    //     /// لو خلص → اعرض زر Resend
                    //     canResend
                    //         ? GestureDetector(
                    //       onTap: () {
                    //         /// 1) إرسال الكود من جديد
                    //         reSend.sendEmail();
                    //
                    //         /// 2) إعادة ضبط العداد
                    //         setState(() {
                    //           totalSeconds = 60;
                    //           canResend = false;
                    //         });
                    //
                    //         /// 3) إعادة تشغيل التايمر
                    //         timer = Timer.periodic(Duration(seconds: 1), (t) {
                    //           if (totalSeconds == 0) {
                    //             t.cancel();
                    //             setState(() {
                    //               canResend = true;
                    //             });
                    //           } else {
                    //             setState(() {
                    //               totalSeconds--;
                    //             });
                    //           }
                    //         });
                    //       },
                    //       child: Text(
                    //         "Resend",
                    //         style: TextStyle(
                    //           fontSize: 14.sp,
                    //           fontWeight: FontWeight.w600,
                    //           color: MyColors.primaryColor,
                    //           decoration: TextDecoration.underline,
                    //         ),
                    //       ),
                    //     )
                    //         : Text(
                    //       formatTime(totalSeconds),
                    //       style: TextStyle(
                    //         fontSize: 14.sp,
                    //         fontWeight: FontWeight.w500,
                    //         color: MyColors.primaryColor,
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
                          viewModel.verifyEmail(userId: widget.userId, code: code);


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