import 'package:dartz/dartz.dart';

import '../Models/Requests/RegisterRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/RegisterResponse.dart';
import '../Services/Remote/ApiManager.dart';


class RegisterRemoteDataSource {
  final ApiManager apiManager;

  RegisterRemoteDataSource(this.apiManager);

  Future<Either<LoginError, RegisterResponse>> register(
      RegisterRequest request) {
    return apiManager.register(request.name ??'', request.email ??'', request.password ??'',
        request.phone ??'',request.gender ??'');
  }


}


