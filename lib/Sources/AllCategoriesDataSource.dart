

import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/AllBooksResponse.dart';
import 'package:online_library_app/Models/Responses/BookReviewResponse.dart';
import 'package:online_library_app/Models/Responses/BooksByCategoryIdResponse.dart';

import '../Models/Requests/ReviewRequest.dart';
import '../Models/Responses/AllCategoriesResponse.dart';
import '../Models/Responses/BookByIdResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/ReviewResponse.dart';
import '../Services/Remote/ApiManager.dart';

class AllCategoriesRemoteDataSource {
  final ApiManager apiManager;

  AllCategoriesRemoteDataSource(this.apiManager);

  Future<Either<LoginError, AllCategoriesResponse>> getAllCategories() {
    return apiManager.getAllCategories();
  }

  Future<Either<LoginError, AllBooksResponse>> getAllBooks() {
    return apiManager.getAllBooks();
  }

  Future<Either<LoginError, BookByIdResponse>> getBookBId(String bookId) {
    return apiManager.getBookByID(bookId);
  }

  Future<Either<LoginError, BooksByCategoryIdResponse>> getBookByCategoryId(String categoryId) {
    return apiManager.getBookByCategoryID(categoryId);
  }

  Future<Either<LoginError, ReviewResponse>> writeReview(
      ReviewRequest request) {
    return apiManager.writeReview(request);
  }

  Future<Either<LoginError, BookReviewResponse>> getBookReview(String bookId) {
    return apiManager.getBookReview(bookId);
  }

}