import 'package:dartz/dartz.dart';

import '../Models/Requests/ResetPasswordRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/ResetPasswordResponse.dart';
import '../Sources/ResetPasswordDataSource.dart';


class ResetPasswordRepository {
  final ResetPasswordRemoteDataSource remoteDataSource;

  ResetPasswordRepository(this.remoteDataSource);

  Future<Either<LoginError, ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request) {
    return remoteDataSource.resetPassword(request);
  }
}