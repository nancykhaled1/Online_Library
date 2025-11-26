import 'package:dartz/dartz.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/NotificationDetailsResponse.dart';
import '../Sources/NotificationDetailsDataSource.dart';

class NotificationDetailsRepository {
  final NotificationDetailsRemoteDataSource remoteDataSource;

  NotificationDetailsRepository(this.remoteDataSource);

  Future<Either<LoginError, NotificationDetailsResponse>> getNotification(String notificationId) {
    return remoteDataSource.GetNotificationDetails(notificationId);
  }
}