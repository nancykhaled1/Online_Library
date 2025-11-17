import 'package:dartz/dartz.dart';

import '../Models/Requests/SendEmailRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/SendEmailResponse.dart';
import '../Services/Remote/ApiManager.dart';


class SendEmailRemoteDataSource {
  final ApiManager apiManager;

  SendEmailRemoteDataSource(this.apiManager);

  Future<Either<LoginError, SendEmailResponse>> sendEmail(
      SendEmailRequest request) {
    return apiManager.sendEmail(request.email!);
  }

}