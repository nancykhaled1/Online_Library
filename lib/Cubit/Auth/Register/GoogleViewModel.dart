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
      print('=== Starting Google Sign In ===');

      final account = await _googleSignIn.signIn();
      print("Account: $account");

      if (account == null) {
        emit(ErrorState(errorMessage: 'Google sign in cancelled'));
        return;
      }

      print("Email: ${account.email}");
      print("Display Name: ${account.displayName}");

      final auth = await account.authentication;

      print("Access Token: ${auth.accessToken}");
      print("ID Token: ${auth.idToken}");

      final idToken = auth.idToken;

      if (idToken == null) {
        print('=== ERROR: ID Token is NULL ===');
        emit(ErrorState(errorMessage: "No ID Token received from Google"));
        return;
      }

      print("=== Sending request to backend ===");
      print("Token length: ${idToken.length}");

      final response = await repository.google(GoogleLoginRequest(token: idToken));

      print("=== Backend Response ===");
      print("Response: $response");

      response.fold(
            (error) {
          print("=== Backend Error ===");
          print("Error: ${error.error?.message}");
          emit(ErrorState(errorMessage: error.error?.message ?? 'Login failed'));
        },
            (googleResponse) async {
          print("=== Backend Success ===");

          final token = googleResponse.token;
          await TokenStorage.saveToken(token);
          print("Saved token: $token");

          final id = googleResponse.user.id;
          await TokenStorage.saveId(id);
          print("Saved user id: $id");

          emit(GoogleSuccessState(response: googleResponse));
        },
      );
    } catch (e, stackTrace) {
      print("=== Exception ===");
      print("Error: $e");
      print("StackTrace: $stackTrace");
      emit(ErrorState(errorMessage: "Error: $e"));
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      print("Signed out successfully");
    } catch (e) {
      print("Sign out error: $e");
    }
  }
}