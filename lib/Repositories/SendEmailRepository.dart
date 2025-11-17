import 'package:dartz/dartz.dart';

import '../Models/Requests/SendEmailRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/SendEmailResponse.dart';
import '../Sources/SendEmailDataSource.dart';

class SendEmailRepository {
  final SendEmailRemoteDataSource remoteDataSource;

  SendEmailRepository(this.remoteDataSource);

  Future<Either<LoginError, SendEmailResponse>> sendEmail(
      SendEmailRequest request) {
    return remoteDataSource.sendEmail(request);
  }
}