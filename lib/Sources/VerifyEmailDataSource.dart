import 'package:dartz/dartz.dart';
import '../Models/Requests/VerifyEmailRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/VerifyEmailResponse.dart';
import '../Services/Remote/ApiManager.dart';

class VerifyEmailRemoteDataSource {
  final ApiManager apiManager;

  VerifyEmailRemoteDataSource(this.apiManager);

  Future<Either<LoginError, VerifyEmailResponse>> verifyEmail(
      VerifyEmailRequest request) {
    return apiManager.verifyEmail(request);
  }

}