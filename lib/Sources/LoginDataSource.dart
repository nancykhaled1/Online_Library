import 'package:dartz/dartz.dart';

import '../Models/Requests/LoginRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/LoginResponse.dart';
import '../Services/Remote/ApiManager.dart';


class LoginRemoteDataSource {
  final ApiManager apiManager;

  LoginRemoteDataSource(this.apiManager);

  Future<Either<LoginError, LoginResponse>> login(
      LoginRequest request) {
    return apiManager.login(request.email!, request.password!);
  }

}