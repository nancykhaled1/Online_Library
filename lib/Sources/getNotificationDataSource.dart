
import 'package:dartz/dartz.dart';

import '../Models/Responses/GetNotificationResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class GetNotificationRemoteDataSource {
  final ApiManager apiManager;

  GetNotificationRemoteDataSource(this.apiManager);

  Future<Either<LoginError, GetNotificationResponse>> GetNotification() {
    return apiManager.getNotification();
  }

}