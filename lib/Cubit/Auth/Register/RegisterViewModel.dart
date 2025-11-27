import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../Models/Requests/RegisterRequest.dart';
import '../../../Models/Responses/LoginError.dart';
import '../../../Models/Responses/RegisterResponse.dart';
import '../../../Repositories/RegisterRepository.dart';
import '../../../Services/Local/SharedPreference.dart';
import '../../States/States.dart';




class RegisterCubit extends Cubit<States> {
  final RegisterRepository repository;

  RegisterCubit(this.repository) : super(InitialState());


  var registerFormKey = GlobalKey<FormState>();


  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();


  bool isPasswordVisible = true;
  bool isRePasswordVisible = true;
  bool showDropdownlevel = false;
  bool isChecked = false;
  List<String> genders = ["male", "female"];



  Future<void> register() async {
   // if (registerFormKey.currentState!.validate()) return;

    emit(LoadingState(loadingMessage: "Registering..."));

    final request = RegisterRequest(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
      gender: genderController.text,

    );

    Either<LoginError, RegisterResponse> response =
    await repository.register(request);

    response.fold(
          (error) {
        emit(ErrorState(errorMessage: error.error!.message));
      },
          (data) async {

        TokenStorage.saveId(data.data!.userId!);
        final savedUserId = await TokenStorage.getUserId();
        print("Saved token locally: $savedUserId");
        emit(RegisterSuccessState(response: data));
      },
    );
  }





  void clearForm() {
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
    nameController.clear();
    phoneController.clear();
    genderController.clear();
    isChecked = false;
    isPasswordVisible = true;
    isRePasswordVisible = true;

    emit(InitialState());
  }

}



