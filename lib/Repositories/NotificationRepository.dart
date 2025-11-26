
import 'package:dartz/dartz.dart';

import '../Models/Requests/NotificationRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/NotificationResponse.dart';
import '../Sources/NotificationDataSource.dart';

class NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepository(this.remoteDataSource);

  Future<Either<LoginError, NotificationResponse>> sendNotification(
      NotificationRequest request) {
    return remoteDataSource.sendNotification(request);
  }
}