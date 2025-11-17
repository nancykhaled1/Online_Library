

import 'package:dartz/dartz.dart';

import '../Models/Requests/VerifyEmailRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/VerifyEmailResponse.dart';
import '../Sources/VerifyEmailDataSource.dart';

class VerifyEmailRepository {
  final VerifyEmailRemoteDataSource remoteDataSource;

  VerifyEmailRepository(this.remoteDataSource);

  Future<Either<LoginError, VerifyEmailResponse>> verifyEmail(
      VerifyEmailRequest request) {
    return remoteDataSource.verifyEmail(request);
  }
}