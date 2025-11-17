import 'package:dartz/dartz.dart';

import '../Models/Requests/ChangePasswordRequest.dart';
import '../Models/Responses/ChangePaswwordResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Sources/ChangePasswordDataSource.dart';




class ChangePasswordRepository {
  final ChangePassRemoteDataSource remoteDataSource;

  ChangePasswordRepository(this.remoteDataSource);

  Future<Either<LoginError, ChangePaswwordResponse>> changePassword(
      ChangePasswordRequest request) {
    return remoteDataSource.changePassword(request);
  }
}