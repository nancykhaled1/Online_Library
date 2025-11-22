import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/ReturnResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class ReturnRemoteDataSource {
  final ApiManager apiManager;

  ReturnRemoteDataSource(this.apiManager);

  Future<Either<LoginError, ReturnResponse>> returnBook(String borrowId) {
    return apiManager.returnBook(borrowId);
  }

  // Future<Either<LoginError, GetBorrowResponse>> getBorrowBook() {
  //   return apiManager.getBorrowBooks();
  // }

}