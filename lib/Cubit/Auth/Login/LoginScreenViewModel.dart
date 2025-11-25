import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/Requests/LoginRequest.dart';
import '../../../Models/Responses/LoginError.dart';
import '../../../Models/Responses/LoginResponse.dart';
import '../../../Repositories/LoginRepository.dart';
import '../../../Services/Local/SharedPreference.dart';
import '../../States/States.dart';


class LoginScreenCubit extends Cubit<States> {
  final LoginRepository repository;

  LoginScreenCubit(this.repository) : super(InitialState());

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = true;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingState(loadingMessage: "Loading..."));

      final request = LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      );

      Either<LoginError, LoginResponse> response =
      await repository.login(request);

      response.fold(
            (error) {
          emit(ErrorState(errorMessage: error.error!.message));
        },
            (data) async {

          //تخزين التوكن
          final token = data.data?.token;
          await TokenStorage.saveToken(token!);
          final savedToken = await TokenStorage.getToken();
          print("Saved token locally: $savedToken");

          // //تخزين الرول
          // final role = data.data?.role;
          // await TokenStorage.saveRole(role!);
          // final savedRole = await TokenStorage.getRole();
          // print("Saved role locally: $savedRole");

          //تخزين ال id
          final userId = data.data?.id;
          await TokenStorage.saveId(userId!);
          final savedUserId = await TokenStorage.getUserId();
          print("Saved id locally: $savedUserId");


          emit(LoginSuccessState(response: data));
        },
      );
    }
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
    isPasswordVisible = true;

    emit(InitialState());
  }
}




