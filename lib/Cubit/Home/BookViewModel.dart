import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_library_app/Models/Responses/AllBooksResponse.dart';

import '../../Models/Responses/AllCategoriesResponse.dart';
import '../../Models/Responses/BooksByCategoryIdResponse.dart';
import '../../Models/Responses/CategoryByIdResponse.dart';
import '../../Repositories/AllCategoriesRepository.dart';
import '../States/States.dart';


class BookCubit extends Cubit<States> {
  final AllCategoriesRepository repository;

  BookCubit(this.repository) : super(InitialState());

  List<BooksByCategoryId> booksByCategory = [];

  Map<String, List<BooksByCategoryId>> cachedBooks = {}; // categoryId → books list


  Future<void> getBookByCategoryId(String categoryId) async {

    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await repository.getBookByCategoryId(categoryId);
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
              booksByCategory = success.data?.books??[];
          emit(BookByCategoryIdSuccessState(book: booksByCategory));
        }

    );
  }

  Future<void> loadHomeData() async {
    emit(LoadingState(loadingMessage: "Loading..."));

    try {
      // 1) Call categories
      final catEither = await repository.getAllCategories();

      List<Categories> categories = [];
      catEither.fold(
            (l) => emit(ErrorState(errorMessage: l.error?.message)),
            (response) {
          categories = response.data?.categories ?? [];
        },
      );

      List<Parents> parents = [];
      catEither.fold(
            (l) => emit(ErrorState(errorMessage: l.error?.message)),
            (response) {
          parents = response.data?.parents ?? [];
        },
      );

      // 2) Call books only if categories loaded successfully
      final booksEither = await repository.getAllBooks();

      List<Books> books = [];
      booksEither.fold(
            (l) => emit(ErrorState(errorMessage: l.error?.message)),
            (response) {
          books = response.data?.books ?? [];
        },
      );


      // 3) Final emit — DONE
      emit(HomeDataSuccessState(
          categories,
          books,
          parents
      ));

    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }



}




