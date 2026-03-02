


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Cubit/Notification/GetNotificationViewModel.dart';
import '../../Cubit/States/States.dart';
import '../../Utils/ErrorWidget.dart';
import '../../Utils/MyColors.dart';
import '../Home/home.dart';
import 'NotificationDetails.dart';
import 'notification_card.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = 'notification';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationScreenViewModel>().getNotification();

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // هنا بتتحكمى هل ترجعى ولا لا
          return false; // ❌ مش هيرجع
          // return true;  ✅ هيرجع
        },
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
                    pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // BlocBuilder لمتابعة الـ state
              Expanded(
                child: BlocBuilder<NotificationScreenViewModel, States>(
                  builder: (context, state) {

                    if (state is LoadingState) {
                      return Center(
                        child: CircularProgressIndicator(
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
                            context.read<NotificationScreenViewModel>().getNotification();
                          },
                        );
                      } else {
                        return AppErrorWidget(
                          imagePath: "assets/images/error.svg",
                          title: "Something went wrong",
                          description: "Please try again later",
                          onRetry: () {
                            context.read<NotificationScreenViewModel>().getNotification();
                          },
                        );
                      }
                    }
                    else if (state is GetNotificationSuccessState) {
                      final notifications = state.notifications;

                      if (notifications.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/notification-slash.svg',
                                  // width: 238,
                                  // height: 238,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text('no notifications yet',
                                  style: TextStyle(
                                    color: MyColors.greyColor,
                                    fontFamily: "Noto Kufi Arabic",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24.sp ,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }


                      return ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notif = notifications[index];
                          if (notif.notification == null) return SizedBox();

                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => NotificationDetailsScreen(notificationId: notif.id ??'',),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            child: NotificationCard(
                              title: notif.notification?.title ?? "",
                              body: notif.notification?.body ?? "",
                              date: notif.createdAt ??'',
                              read: notif.read ?? false,
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
