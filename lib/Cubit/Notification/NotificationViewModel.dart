import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Requests/NotificationRequest.dart';
import '../../Repositories/NotificationRepository.dart';
import '../States/States.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class NotificationCubit extends Cubit<States> {
  final NotificationRepository repository;
  NotificationCubit(this.repository) : super(InitialState());

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();



  // /// 🧾 طلب إذن الإشعارات
  // Future<void> requestNotificationPermission() async {
  //   var status = await Permission.notification.status;
  //
  //   if (status.isDenied) {
  //     await Permission.notification.request();
  //   }
  //
  //   if (status.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  // }

  /// 🔔 جلب الـ FCM Token
  Future<void> getFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("📱 FCM Token: $token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token ?? '');
  }

  /// 👂 الاستماع للإشعارات (يشتغل فقط لو الإشعارات مفعّلة)
  void listenToMessages() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final prefs = await SharedPreferences.getInstance();
      final enabled = prefs.getBool('notifications_enabled') ?? true;
      final muted = prefs.getBool('mute_notifications') ?? false;

      if (!enabled) {
        print("🔕 Notification received but disabled by user.");
        return;
      }

      if (muted) {
        print("🔇 Notification muted — will not show alert.");
        // ممكن تخزنيها محليًا من غير ما تعرضيها
        return;
      }

      // هنا بتتعاملِ مع الإشعار عادي لما مش مكتوم
      print('📩 New notification shown: ${message.notification?.title}');
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      final prefs = await SharedPreferences.getInstance();
      final enabled = prefs.getBool('notifications_enabled') ?? true;

      if (!enabled) {
        print("🔕 Notification opened but notifications are disabled.");
        return; // ❌ متتنقليش للشاشة
      }

      print("App opened from notification: ${message.notification?.title}");
     // navigatorKey.currentState?.pushNamed(NotificationScreen.routeName);
    });
  }

  /// 📤 إرسال الـ Token للباك
  Future<void> sendFcmToken() async {
    emit(LoadingState(loadingMessage: 'Loading..'));

    try {
      String? token = await FirebaseMessaging.instance.getToken();

      if (token == null) {
        emit(ErrorState(errorMessage: "Failed to get FCM token"));
        return;
      }

      final request = NotificationRequest(token: token);
      final response = await repository.sendNotification(request);

      response.fold(
            (error) {
          emit(ErrorState(errorMessage: "Server error: ${error.error?.message}"));
        },
            (response) {
          emit(NotificationSuccessState(response: response));
        },
      );
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}


