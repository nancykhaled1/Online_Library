

import 'package:dartz/dartz.dart';

import '../Models/Requests/GoogleRequest.dart';
import '../Models/Responses/GoogleResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Sources/GoogleDataSource.dart';

class GoogleRepository {
  final GoogleDataSource remoteDataSource;

  GoogleRepository(this.remoteDataSource);

  Future<Either<LoginError, GoogleResponse>> google(
      GoogleLoginRequest request) {
    return remoteDataSource.google(request);
  }
}