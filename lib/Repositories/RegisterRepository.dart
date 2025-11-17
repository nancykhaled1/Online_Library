import 'package:dartz/dartz.dart';

import '../Models/Requests/RegisterRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/RegisterResponse.dart';
import '../Sources/RegisterDataSource.dart';



class RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;

  RegisterRepository(this.remoteDataSource);

  Future<Either<LoginError, RegisterResponse>> register(
      RegisterRequest request) {
    return remoteDataSource.register(request);
  }

}
