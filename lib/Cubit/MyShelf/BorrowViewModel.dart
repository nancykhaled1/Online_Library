import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_library_app/Repositories/BorrowRepository.dart';
import '../../Models/Responses/GetBorrowResponse.dart';
import '../States/States.dart';

class BorrowCubit extends Cubit<States> {
  final BorrowRepository repository;

  BorrowCubit(this.repository) : super(InitialState());


  List<Borrowed> borrowedBook = [];
  List<Returned> returnedBook = [];



  Future<void> borrowBooks(String bookId) async {
    emit(LoadingState(loadingMessage: 'Loading..')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await repository.borrowBook(bookId);
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          emit(BorrowBooksSuccessState(borrowData: success.data!));
        }

    );
  }

  Future<void> getBorrowBooks() async {
    emit(LoadingState(loadingMessage: 'Loading..')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await repository.getBorrowBook();
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
              borrowedBook = success.data?.borrowed ??[];
              returnedBook = success.data?.returned ??[];
          emit(GetBorrowBooksSuccessState(borrow: borrowedBook, returned: returnedBook));
        }
    );
  }





}
