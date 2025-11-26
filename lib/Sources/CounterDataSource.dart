

import 'package:dartz/dartz.dart';

import '../Models/Responses/CounterResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class CounterRemoteDataSource {
  final ApiManager apiManager;

  CounterRemoteDataSource(this.apiManager);

  Future<Either<LoginError, CounterResponse>> GetCounter() {
    return apiManager.getCounter();
  }

}