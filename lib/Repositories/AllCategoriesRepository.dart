import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/AllBooksResponse.dart';
import 'package:online_library_app/Models/Responses/BookReviewResponse.dart';
import 'package:online_library_app/Models/Responses/BooksByCategoryIdResponse.dart';

import '../Models/Requests/ReviewRequest.dart';
import '../Models/Responses/AllCategoriesResponse.dart';
import '../Models/Responses/BookByIdResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Models/Responses/ReviewResponse.dart';
import '../Sources/AllCategoriesDataSource.dart';


class AllCategoriesRepository {
  final AllCategoriesRemoteDataSource remoteDataSource;

  AllCategoriesRepository(this.remoteDataSource);

  Future<Either<LoginError, AllCategoriesResponse>> getAllCategories() {
    return remoteDataSource.getAllCategories();
  }

  Future<Either<LoginError, AllBooksResponse>> getAllBooks() {
    return remoteDataSource.getAllBooks();
  }

  Future<Either<LoginError, BookByIdResponse>> getBookById(String bookId) {
    return remoteDataSource.getBookBId(bookId);
  }

  Future<Either<LoginError, BooksByCategoryIdResponse>> getBookByCategoryId(String categoryId) {
    return remoteDataSource.getBookByCategoryId(categoryId);
  }

  Future<Either<LoginError, ReviewResponse>> writeReview(
      ReviewRequest request) {
    return remoteDataSource.writeReview(request);
  }

  Future<Either<LoginError, BookReviewResponse>> getBookReview(String bookId) {
    return remoteDataSource.getBookReview(bookId);
  }
}