import 'package:dartz/dartz.dart';

import '../Models/Requests/ChangePasswordRequest.dart';
import '../Models/Responses/ChangePaswwordResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class ChangePassRemoteDataSource {
  final ApiManager apiManager;

  ChangePassRemoteDataSource(this.apiManager);

  Future<Either<LoginError, ChangePaswwordResponse>> changePassword(
      ChangePasswordRequest request) {
    return apiManager.changePassword(request.email!, request.code!, request.newPassword!);
  }

}