import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_library_app/Models/Responses/AllBooksResponse.dart';

import '../../Models/Responses/AllCategoriesResponse.dart';
import '../../Repositories/AllCategoriesRepository.dart';
import '../States/States.dart';


class CategoryCubit extends Cubit<States> {
  final AllCategoriesRepository repository;

  CategoryCubit(this.repository) : super(InitialState());

  List<Categories> allCategories = [];

  Future<void> getBookByCategoryId(String categoryId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await repository.getBookByCategoryId(categoryId);
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          emit(BookByCategoryIdSuccessState(book: success.data!));
        }

    );
  }



}




