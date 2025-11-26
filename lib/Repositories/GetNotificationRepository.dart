import 'package:dartz/dartz.dart';
import '../Models/Responses/GetNotificationResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Sources/getNotificationDataSource.dart';

class GetNotificationRepository {
  final GetNotificationRemoteDataSource remoteDataSource;

  GetNotificationRepository(this.remoteDataSource);

  Future<Either<LoginError, GetNotificationResponse>> getNotification() {
    return remoteDataSource.GetNotification();
  }
}