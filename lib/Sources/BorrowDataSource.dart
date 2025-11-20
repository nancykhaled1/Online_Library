import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/BorrowResponse.dart';
import 'package:online_library_app/Models/Responses/GetBorrowResponse.dart';

import '../Models/Requests/ChangePasswordRequest.dart';
import '../Models/Responses/ChangePaswwordResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class BorrowRemoteDataSource {
  final ApiManager apiManager;

  BorrowRemoteDataSource(this.apiManager);

  Future<Either<LoginError, BorrowResponse>> borrowBook(String bookId) {
    return apiManager.borrowBook(bookId);
  }

  Future<Either<LoginError, GetBorrowResponse>> getBorrowBook() {
    return apiManager.getBorrowBooks();
  }

}