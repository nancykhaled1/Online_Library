import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/SearchResponse.dart';
import 'package:online_library_app/Sources/SearchDataSource.dart';

import '../Models/Responses/LoginError.dart';

class SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepository(this.remoteDataSource);

  Future<Either<LoginError, SearchResponse>> searchBooks(String query) {
    return remoteDataSource.searchBooks(query);
  }
}