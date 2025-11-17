import 'package:dartz/dartz.dart';

import '../Models/Requests/LoginRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/LoginResponse.dart';
import '../Sources/LoginDataSource.dart';


class LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepository(this.remoteDataSource);

  Future<Either<LoginError, LoginResponse>> login(
      LoginRequest request) {
    return remoteDataSource.login(request);
  }
}