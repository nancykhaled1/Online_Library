import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:online_library_app/Models/Responses/AllSavedBooksResponse.dart';
import '../../Models/Requests/SaveBookRequest.dart';
import '../../Models/Responses/SaveBookResponse.dart';
import '../../Repositories/SaveBookRepository.dart';
import '../States/States.dart';

class SaveListCubit extends Cubit<States> {
  final SaveBookRepository repository;

  SaveListCubit(this.repository) : super(InitialState());

  List<String> savedBookIds = []; // لتخزين الـ bookIds المحفوظة

  List<Favorites> favorites = []; // لتخزين الـ bookIds المحفوظة


  /// دالة لحفظ الكتاب
  Future<void> saveBook(SaveBookRequest request) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل'));

    var either = await repository.saveBook(request);
    either.fold(
          (l) {
        emit(ErrorState(errorMessage: l.error?.message ?? "حدث خطأ"));
      },
          (success) {
        // لو الكتاب مش موجود في القائمة اضيفيه
        if (request.bookId != null && !savedBookIds.contains(request.bookId)) {
          savedBookIds.add(request.bookId!);
        }

        emit(SaveBookSuccessState(response: success));
      },
    );
  }

  /// للتحقق إذا الكتاب محفوظ أم لا
  bool isBookSaved(String bookId) {
    return savedBookIds.contains(bookId);
  }


  Future<void> getSaveBooks() async {
    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await repository.getSaveBooks();
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
              favorites = success.data?.favorites ??[];
          emit(AllSaveBookSuccessState(favorite: favorites));
        }

    );
  }


  /// دالة لإزالة الكتاب من المفضلة
  Future<void> removeSavedBook(String bookId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل'));

    // نحتاج نعمل request للـ repository لإزالة الكتاب
    var either = await repository.removeSavedBook(bookId);

    either.fold(
          (l) {
        // في حالة الخطأ
        emit(ErrorState(errorMessage: l.error?.message ?? "حدث خطأ"));
      },
          (success) {
        // إزالة الـ bookId من قائمة الـ savedBookIds
        savedBookIds.remove(bookId);

        // إزالة الكتاب من قائمة الـ favorites
        favorites.removeWhere((fav) => fav.bookId == bookId);

        // إصدار حالة النجاح مع بيانات محدّثة
        emit(RemoveSavedBookSuccessState(removeData: success.data!));
      },
    );
  }


}
