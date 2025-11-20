import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/BorrowResponse.dart';
import 'package:online_library_app/Models/Responses/GetBorrowResponse.dart';
import 'package:online_library_app/Sources/BorrowDataSource.dart';
import '../Models/Requests/ChangePasswordRequest.dart';
import '../Models/Responses/ChangePaswwordResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Sources/ChangePasswordDataSource.dart';




class BorrowRepository {
  final BorrowRemoteDataSource remoteDataSource;

  BorrowRepository(this.remoteDataSource);

  Future<Either<LoginError, BorrowResponse>> borrowBook(String bookId) {
    return remoteDataSource.borrowBook(bookId);
  }

  Future<Either<LoginError, GetBorrowResponse>> getBorrowBook() {
    return remoteDataSource.getBorrowBook();
  }
}