import 'package:dartz/dartz.dart';

import '../Models/Requests/ResetPasswordRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/ResetPasswordResponse.dart';
import '../Services/Remote/ApiManager.dart';


class ResetPasswordRemoteDataSource {
  final ApiManager apiManager;

  ResetPasswordRemoteDataSource(this.apiManager);

  Future<Either<LoginError, ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request) {
    return apiManager.resetPassword(request);
  }

}