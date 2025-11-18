import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/SaveBookResponse.dart';
import 'package:online_library_app/Sources/SaveBookDataSource.dart';

import '../Models/Requests/SaveBookRequest.dart';
import '../Models/Responses/AllSavedBooksResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/RemoveSavedBook.dart';
import '../Services/Remote/ApiManager.dart';

class SaveBookRepository {
  final SaveBookRemoteDataSource remoteDataSource;

  SaveBookRepository(this.remoteDataSource);

  Future<Either<LoginError, SaveBookResponse>> saveBook(SaveBookRequest request) {
    return remoteDataSource.saveBook(request);
  }

  Future<Either<LoginError, AllSavedBooksResponse>> getSaveBooks() {
    return remoteDataSource.getSaveBooks();
  }

  Future<Either<LoginError, RemoveSavedBook>> removeSavedBook(String bookId) {
    return remoteDataSource.removeSavedBook(bookId);
  }
}