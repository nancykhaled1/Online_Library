import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_library_app/Cubit/States/States.dart';
import 'package:online_library_app/Models/Responses/SearchResponse.dart';
import 'package:online_library_app/Repositories/SearchRepository.dart';

class SearchScreenCubit extends Cubit<States>{
  SearchRepository repository;

  List<SearchBooks> searchResults = [];


  SearchScreenCubit(this.repository) : super(InitialState());


  Future<void> searchBooks(String query) async {
    emit(LoadingState(loadingMessage: 'جارى البحث...'));

    var either = await repository.searchBooks(query);

    either.fold(
          (l) {
        emit(ErrorState(errorMessage: l.error?.message ?? "حدث خطأ"));
      },
          (success) {
        // حفظ النتائج في المتغير المحلي
        searchResults = success.data?.books ?? [];

        emit(SearchBooksSuccessState(search: searchResults));
      },
    );
  }

  void clearSearchResults() {
      emit(InitialState());

  }

}