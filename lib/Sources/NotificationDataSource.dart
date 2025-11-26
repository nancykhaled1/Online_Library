

import 'package:dartz/dartz.dart';

import '../Models/Requests/NotificationRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/NotificationResponse.dart';
import '../Services/Remote/ApiManager.dart';

class NotificationRemoteDataSource {
  final ApiManager apiManager;

  NotificationRemoteDataSource(this.apiManager);

  Future<Either<LoginError, NotificationResponse>> sendNotification(
      NotificationRequest request) {
    return apiManager.sendNotification(request);
  }

}