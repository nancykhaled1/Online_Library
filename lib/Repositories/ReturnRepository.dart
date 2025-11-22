import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/ReturnResponse.dart';
import 'package:online_library_app/Sources/ReturnDataSource.dart';
import '../Models/Responses/LoginError.dart';




class ReturnRepository {
  final ReturnRemoteDataSource remoteDataSource;

  ReturnRepository(this.remoteDataSource);

  Future<Either<LoginError, ReturnResponse>> returnBook(String borrowId) {
    return remoteDataSource.returnBook(borrowId);
  }

  // Future<Either<LoginError, GetBorrowResponse>> getBorrowBook() {
  //   return remoteDataSource.getBorrowBook();
  // }
}