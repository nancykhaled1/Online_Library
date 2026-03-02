import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../Cubit/Notification/NotificationDetailsViewModel.dart';
import '../../Cubit/Profile/ProfileViewModel.dart';
import '../../Cubit/States/States.dart';
import '../../Utils/ErrorWidget.dart';
import '../../Utils/MyColors.dart';
import 'notification_screen.dart';

class NotificationDetailsScreen extends StatefulWidget {
  final String notificationId;
  static const String routeName = 'details';

  const NotificationDetailsScreen({Key? key, required this.notificationId})
    : super(key: key);

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationDetailsViewModel>().getNotificationDetails(
      widget.notificationId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // هنا بتتحكمى هل ترجعى ولا لا
        return false; // ❌ مش هيرجع
        // return true;  ✅ هيرجع
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          appBar:AppBar(
            backgroundColor: MyColors.whiteColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: Text(
              'Notifications',
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
                    pageBuilder: (context, animation, secondaryAnimation) => NotificationScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  BlocBuilder<NotificationDetailsViewModel, States>(
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return Center(
                              child: CircularProgressIndicator(
                              ),
                            );
                          } else if (state is NotificationDetailsSuccessState) {
                            final details =
                                state.notificationDetails.notification?.notification ; // ده الريسبونس اللى جاي من الباك
                            final parsedDate =
                            DateTime.parse(details!.createdAt!).toLocal();
                            final formattedDate = DateFormat(
                              'HH:mm – dd/MM/yyyy',
                            ).format(parsedDate);
              
              
              
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: MyColors.whiteColor,
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: MyColors.greyColor.withOpacity(0.25),
                                    blurRadius: 15,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20.h),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                              color: MyColors.outColor ,
                                              borderRadius: BorderRadius.circular(10.r)
                                          ),
              
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/Fire.png',
                                              width: 24,
                                              height: 24,
                                              // color: MyColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.h),
              
                                        Expanded(
                                          child: Text(
                                            details.title ?? '',
                                            maxLines: 4,
                                            //softWrap: true,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w500,
                                              color: MyColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      details.body ?? '',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: MyColors.blackColor,
                                        height: 1.5.h,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.timer_outlined,color: MyColors.greyColor,size: 15.sp,),
                                        SizedBox(width: 5.w,),
                                        Text(
                                          '$formattedDate',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            color: MyColors.greyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          else if (state is ErrorState) {
                            final error = state.errorMessage;

                            if (error == "No Internet Connection") {
                              return AppErrorWidget(
                                imagePath: "assets/images/noconnection.svg",
                                title: "No internet connection",
                                description: "Please check your network and try again",
                                onRetry: () {
                                  context.read<NotificationDetailsViewModel>().getNotificationDetails(
                                    widget.notificationId,
                                  );                                },
                              );
                            } else {
                              return AppErrorWidget(
                                imagePath: "assets/images/error.svg",
                                title: "Something went wrong",
                                description: "Please try again later",
                                onRetry: () {
                                  context.read<NotificationDetailsViewModel>().getNotificationDetails(
                                    widget.notificationId,
                                  );
                                  },
                              );
                            }
                          }
                          else {
                            return const SizedBox();
                          }
                        },
                      ),
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
