import 'package:dartz/dartz.dart';
import '../Models/Responses/CounterResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Sources/CounterDataSource.dart';

class CounterRepository {
  final CounterRemoteDataSource remoteDataSource;

  CounterRepository(this.remoteDataSource);

  Future<Either<LoginError, CounterResponse>> getCounter() {
    return remoteDataSource.GetCounter();
  }
}