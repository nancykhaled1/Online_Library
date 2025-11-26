

import 'package:dartz/dartz.dart';

import '../Models/Responses/LoginError.dart';
import '../Models/Responses/NotificationDetailsResponse.dart';
import '../Services/Remote/ApiManager.dart';

class NotificationDetailsRemoteDataSource {
  final ApiManager apiManager;

  NotificationDetailsRemoteDataSource(this.apiManager);

  Future<Either<LoginError, NotificationDetailsResponse>> GetNotificationDetails(String notificationId) {
    return apiManager.getNotificationByID(notificationId);
  }

}