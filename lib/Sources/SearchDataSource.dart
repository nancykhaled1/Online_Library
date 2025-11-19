import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/SearchResponse.dart';
import '../Models/Responses/LoginError.dart';
import '../Services/Remote/ApiManager.dart';

class SearchRemoteDataSource {
  final ApiManager apiManager;

  SearchRemoteDataSource(this.apiManager);

  Future<Either<LoginError, SearchResponse>> searchBooks(String query) {
    return apiManager.searchBooks(query);
  }

}