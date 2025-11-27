import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../Models/Requests/GoogleRequest.dart';
import '../../../Repositories/GoogleRepository.dart';
import '../../../Services/Local/SharedPreference.dart';
import '../../States/States.dart';

class GoogleCubit extends Cubit<States> {
  final GoogleRepository repository;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: "813623514492-ouif2n91mq1qcvkmgt4a3cekuuf1692q.apps.googleusercontent.com",
  );

  GoogleCubit(this.repository) : super(InitialState());

  Future<void> signInWithGoogle() async {
    emit(LoadingState(loadingMessage: 'Loading........'));
    try {
      await _googleSignIn.signOut();

      final account = await _googleSignIn.signIn();
      print("ACCOUNT RESULT = $account");
      if (account == null) {
        emit(ErrorState(errorMessage: 'Google sign in cancelled'));
        return;
      }

      final auth = await account.authentication;
      final idToken = auth.idToken;
      print("idToken: $idToken");



      if (idToken == null) {
        emit(ErrorState(errorMessage: "No ID Token received from Google"));
        return;
      }


      print("Sending request to backend...");

      // ابعت idToken للباك اند
      final response = await repository.google(GoogleLoginRequest(token: idToken, ));

      print("Backend returned response: $response");

      response.fold(
        // في حالة error
            (error) {
          emit(ErrorState(errorMessage: error.error?.message ?? 'Login failed'));
        },
        // في حالة success
            (googleResponse) async {
          final token = googleResponse.token;
          await TokenStorage.saveToken(token);
          final savedToken = await TokenStorage.getToken();
          print("Saved token locally: $savedToken");




          final id = googleResponse.user.id;
          await TokenStorage.saveId(id);
          final savedId = await TokenStorage.getUserId();
          print("Saved id locally: $savedId");




          emit(GoogleSuccessState(response: googleResponse));
                },
      );
    } catch (e) {
      emit(ErrorState(errorMessage: "Error: $e"));
    }
  }
}

