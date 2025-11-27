

import 'package:dartz/dartz.dart';

import '../Models/Requests/GoogleRequest.dart';
import '../Models/Responses/GoogleResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class GoogleDataSource {
  final ApiManager apiManager;

  GoogleDataSource(this.apiManager);

  Future<Either<LoginError, GoogleResponse>> google(
      GoogleLoginRequest request) {
    return apiManager.googleLogin(request.token);
  }
}
