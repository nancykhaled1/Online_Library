import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_library_app/Repositories/BorrowRepository.dart';
import 'package:online_library_app/Repositories/ReturnRepository.dart';
import '../../Models/Responses/GetBorrowResponse.dart';
import '../States/States.dart';

class ReturnedCubit extends Cubit<States> {
  final ReturnRepository repository;

  ReturnedCubit(this.repository) : super(InitialState());


  List<Returned> returnedBook = [];


  Future<void> returnBooks(String borrowId) async {
    emit(LoadingState(loadingMessage: 'Loading..')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await repository.returnBook(borrowId);
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          emit(ReturnBooksSuccessState(returnData: success.data!));
        }

    );
  }


  // Future<void> getBorrowBooks() async {
  //   emit(LoadingState(loadingMessage: 'Loading..')); // ⬅️ عشان يمسح القديم ويعرض loader
  //
  //   var either = await repository.getBorrowBook();
  //   either.fold(
  //           (l) {
  //         emit(ErrorState(errorMessage: l.error?.message));
  //       },
  //           (success) {
  //         borrowedBook = success.data?.borrowed ??[];
  //         emit(GetBorrowBooksSuccessState(borrow: borrowedBook));
  //       }
  //   );
  // }







}
