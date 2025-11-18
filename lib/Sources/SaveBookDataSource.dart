import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/AllSavedBooksResponse.dart';
import 'package:online_library_app/Models/Responses/RemoveSavedBook.dart';
import 'package:online_library_app/Models/Responses/SaveBookResponse.dart';

import '../Models/Requests/SaveBookRequest.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class SaveBookRemoteDataSource {
  final ApiManager apiManager;

  SaveBookRemoteDataSource(this.apiManager);

  Future<Either<LoginError, SaveBookResponse>> saveBook(SaveBookRequest request) {
    return apiManager.saveBook(request);
  }

  Future<Either<LoginError, AllSavedBooksResponse>> getSaveBooks() {
    return apiManager.getSaveBooks();
  }


  Future<Either<LoginError, RemoveSavedBook>> removeSavedBook(String bookId) {
    return apiManager.removeSavedBooks(bookId);
  }

}