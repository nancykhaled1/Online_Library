

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/Requests/VerifyEmailRequest.dart';
import '../../../Repositories/VerifyEmailRepository.dart';
import '../../../Services/Local/SharedPreference.dart';
import '../../States/States.dart';

class VerifyEmailCubit extends Cubit<States> {
  final VerifyEmailRepository repository;

  VerifyEmailCubit(this.repository) : super(InitialState());

  TextEditingController codeController = TextEditingController();
  List<TextEditingController> controllers =
  List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  bool isCodeComplete = false;
  void checkCodeCompletion() {
    isCodeComplete = controllers.every((controller) => controller.text.isNotEmpty);
    emit(InitialState()); // علشان يعيد بناء الـ UI ويعرف إن في تغيير
  }




  String getEnteredCode() {
    return controllers.map((e) => e.text).join();
  }

  Future<void> verifyEmail({required String userId , required String code}) async {
    emit(LoadingState(loadingMessage: "Verifying..."));

    final request = VerifyEmailRequest(
      userId: userId,
      code: code,
    );

    final response = await repository.verifyEmail(request);

    response.fold(
          (error) {
        emit(ErrorState(errorMessage: error.error?.message));
      },
          (data)async {
        if (data.success != null)  {
          final token = data.data.token;
          await TokenStorage.saveToken(token);
          final savedToken = await TokenStorage.getToken();
          print("Saved token locally: $savedToken");
          emit(VerifyEmailSuccessState(response: data));
        } else {
          emit(ErrorState(errorMessage: data.data.message));
        }
      },
    );
  }
}
