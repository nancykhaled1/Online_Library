import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/Requests/SendEmailRequest.dart';
import '../../../Models/Responses/LoginError.dart';
import '../../../Models/Responses/SendEmailResponse.dart';
import '../../../Repositories/SendEmailRepository.dart';
import '../../States/States.dart';


class ForgetPassScreenCubit extends Cubit<States> {
  final SendEmailRepository repository;

  ForgetPassScreenCubit(this.repository) : super(InitialState());

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();


  Future<void> sendEmail() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingState(loadingMessage: "Loading..."));

      final request = SendEmailRequest(
        email: emailController.text,
      );

      Either<LoginError, SendEmailResponse> response =
      await repository.sendEmail(request);

      response.fold(
            (error) {
          emit(ErrorState(errorMessage: error.error!.message));
        },
            (data) async {


          // ابعتي الـ Success State
          emit(SendEmailSuccessState(response: data));
        },
      );
    }
  }
}
