

import 'package:online_library_app/Models/Responses/AllBooksResponse.dart';
import 'package:online_library_app/Models/Responses/BookReviewResponse.dart';
import 'package:online_library_app/Models/Responses/BooksByCategoryIdResponse.dart';
import 'package:online_library_app/Models/Responses/CategoryByIdResponse.dart';
import 'package:online_library_app/Models/Responses/ReviewResponse.dart';
import 'package:online_library_app/Models/Responses/SaveBookResponse.dart';

import '../../Models/Responses/AllCategoriesResponse.dart';
import '../../Models/Responses/AllSavedBooksResponse.dart';
import '../../Models/Responses/BookByIdResponse.dart';
import '../../Models/Responses/ChangePaswwordResponse.dart';
import '../../Models/Responses/GoogleResponse.dart';
import '../../Models/Responses/LoginResponse.dart';
import '../../Models/Responses/RegisterResponse.dart';
import '../../Models/Responses/RemoveSavedBook.dart';
import '../../Models/Responses/ResetPasswordResponse.dart';
import '../../Models/Responses/SendEmailResponse.dart';
import '../../Models/Responses/VerifyEmailResponse.dart';

abstract class States{}

class InitialState extends States{}

class LoadingState extends States{
  String? loadingMessage;
  LoadingState({required this.loadingMessage});
}


class BookLoadingState extends States{
  String? loadingMessage;
  BookLoadingState({required this.loadingMessage});
}




class ErrorState extends States{
  String? errorMessage;
  ErrorState({required this.errorMessage});
}

class RegisterSuccessState extends States {
  final RegisterResponse response;

  RegisterSuccessState({required this.response});
}

class LoginSuccessState extends States {
  final LoginResponse response;

  LoginSuccessState({required this.response});
}

class SendEmailSuccessState extends States {
  final SendEmailResponse response;

  SendEmailSuccessState({required this.response});
}

class SendCodeSuccessState extends States {
  final ResetPasswordResponse response;

  SendCodeSuccessState({required this.response});
}

class ResetPassSuccessState extends States {
  final ResetPasswordResponse response;

  ResetPassSuccessState({required this.response});
}

class ChangePassSuccessState extends States {
  final ChangePaswwordResponse response;

  ChangePassSuccessState({required this.response});
}


class VerifyEmailSuccessState extends States {
  final VerifyEmailResponse response;

  VerifyEmailSuccessState({required this.response});
}

class GoogleSuccessState extends States {
  final GoogleResponse response;

  GoogleSuccessState({required this.response});
}


class HomeDataSuccessState extends States {
  final List<Categories> categories;
  final List<Parents> parents;
  final List<Books> books;

  HomeDataSuccessState(this.categories, this.books, this.parents);
}


class BookDetailsSuccessState extends States {
  final BookById book;

  BookDetailsSuccessState({required this.book});
}

class BookByCategoryIdSuccessState extends States {
  final List<BooksByCategoryId> book;

  BookByCategoryIdSuccessState({required this.book});
}

class CategoryByIdSuccessState extends States {
  final List<Children> children;

  CategoryByIdSuccessState({required this.children});
}

class ReviewSuccessState extends States {
  final ReviewResponse response;

  ReviewSuccessState({required this.response});
}

class GetReviewSuccessState extends States {
  final List<Reviews> review;

  GetReviewSuccessState({required this.review});
}


class SaveBookSuccessState extends States {
  final SaveBookResponse response;

  SaveBookSuccessState({required this.response});
}


class AllSaveBookSuccessState extends States {
  final List<Favorites> favorite;

  AllSaveBookSuccessState({required this.favorite});
}


class RemoveSavedBookSuccessState extends States {
  final RemoveData removeData;

  RemoveSavedBookSuccessState({required this.removeData});
}


