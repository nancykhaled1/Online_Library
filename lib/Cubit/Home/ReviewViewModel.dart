import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_library_app/Models/Responses/AllBooksResponse.dart';

import '../../Models/Requests/ReviewRequest.dart';
import '../../Models/Responses/AllCategoriesResponse.dart';
import '../../Models/Responses/BookReviewResponse.dart';
import '../../Repositories/AllCategoriesRepository.dart';
import '../States/States.dart';


class ReviewCubit extends Cubit<States> {
  final AllCategoriesRepository repository;

  ReviewCubit(this.repository) : super(InitialState());
  List<Reviews> review = [];




  Future<void> submitBookReview(ReviewRequest request) async {
    emit(LoadingState(loadingMessage: "Submitting review..."));

    try {
      final either = await repository.writeReview(request);

      await either.fold(
            (l) async {
          // ❌ Error حصل -> اعرضه
          emit(ErrorState(errorMessage: l.error?.message));

          // ✔ اعملي Refresh للريفيوهات برضو
          await getBookReview(request.bookId!, showLoading: false);
        },
            (success) async {
          // ✔ الريفيو اتسجل
          emit(ReviewSuccessState(response: success));

          // ✔ رجعي الريفيوهات بعد الريفيو الجديد
          await getBookReview(request.bookId!, showLoading: false);
        },
      );
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getBookReview(String bookId, {bool showLoading = true}) async {
    if (showLoading) {
      emit(LoadingState(loadingMessage: 'جارى التحميل'));
    }

    var either = await repository.getBookReview(bookId);

    either.fold(
          (l) => emit(ErrorState(errorMessage: l.error?.message)),
          (success) {
        review = success.data?.reviews ?? [];
        emit(GetReviewSuccessState(review: review));
      },
    );
  }




}




