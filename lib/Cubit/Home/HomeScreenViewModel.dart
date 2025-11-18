import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_library_app/Models/Responses/AllBooksResponse.dart';
import 'package:online_library_app/Models/Responses/CategoryByIdResponse.dart';

import '../../Models/Requests/ReviewRequest.dart';
import '../../Models/Responses/AllCategoriesResponse.dart';
import '../../Models/Responses/BookReviewResponse.dart';
import '../../Repositories/AllCategoriesRepository.dart';
import '../States/States.dart';


class HomeScreenCubit extends Cubit<States> {
  final AllCategoriesRepository repository;

  HomeScreenCubit(this.repository) : super(InitialState());
  List<Reviews> review = [];

  List<Children> children = [];




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








  Future<void> getBookDetails(String bookId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await repository.getBookById(bookId);
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          emit(BookDetailsSuccessState(book: success.data!.book!));
        }

    );
  }



  Future<void> getBookReview(String bookId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await repository.getBookReview(bookId);
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
              review = success.data?.reviews ??[];
          emit(GetReviewSuccessState(review: review));
        }

    );
  }



}




