



import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:online_library_app/Models/Requests/ReviewRequest.dart';
import 'package:online_library_app/Models/Requests/SaveBookRequest.dart';
import 'package:online_library_app/Models/Responses/AllSavedBooksResponse.dart';
import 'package:online_library_app/Models/Responses/BookByIdResponse.dart';
import 'package:online_library_app/Models/Responses/BookReviewResponse.dart';
import 'package:online_library_app/Models/Responses/BooksByCategoryIdResponse.dart';
import 'package:online_library_app/Models/Responses/BorrowResponse.dart';
import 'package:online_library_app/Models/Responses/CategoryByIdResponse.dart';
import 'package:online_library_app/Models/Responses/GetBorrowResponse.dart';
import 'package:online_library_app/Models/Responses/RemoveSavedBook.dart';
import 'package:online_library_app/Models/Responses/ReturnResponse.dart';
import 'package:online_library_app/Models/Responses/ReviewResponse.dart';

import '../../Models/Requests/ChangePasswordRequest.dart';
import '../../Models/Requests/LoginRequest.dart';
import '../../Models/Requests/RegisterRequest.dart';
import '../../Models/Requests/ResetPasswordRequest.dart';
import '../../Models/Requests/SendEmailRequest.dart';
import '../../Models/Requests/VerifyEmailRequest.dart';
import '../../Models/Responses/AllBooksResponse.dart';
import '../../Models/Responses/AllCategoriesResponse.dart';
import '../../Models/Responses/ChangePaswwordResponse.dart';
import '../../Models/Responses/GoogleResponse.dart';
import '../../Models/Responses/LoginError.dart';
import '../../Models/Responses/LoginResponse.dart';
import '../../Models/Responses/RegisterResponse.dart';
import '../../Models/Responses/ResetPasswordResponse.dart';
import '../../Models/Responses/SaveBookResponse.dart';
import '../../Models/Responses/SearchResponse.dart';
import '../../Models/Responses/SendEmailResponse.dart';
import '../../Models/Responses/VerifyEmailResponse.dart';
import '../Local/SharedPreference.dart';
import 'ApiConstants.dart';

class ApiManager{
  Future<Either<LoginError, LoginResponse>> login(
      String email,
      String password,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.LoginApi);

        var requestBody = LoginRequest(
          email: email ?? '',
          password: password ?? '',
        );

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            requestBody.toJson(),
          ), // تأكد toJson يرجع Map<String, dynamic>
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var registerResponse = LoginResponse.fromJson(jsonResponse);
          return right(registerResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }


  Future<Either<LoginError, RegisterResponse>> register(
      String name,
      String email,
      String password,
      String phone,
      String gender,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(
          ApiConstants.baseurl,
          ApiConstants.RegisterApi,
        );

        var requestBody = RegisterRequest(
            email: email,
            password: password,
            name: name,
            phone: phone,
            gender: gender,
        );

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(url, body: requestBody.toJson());

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var registerResponse = RegisterResponse.fromJson(jsonResponse);
          return right(registerResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
              // details: "Please check your connection and try again.",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: -1,
            message: "Unexpected Error",
            // details: e.toString(),
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, SendEmailResponse>> sendEmail(String email) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.sendEmailApi);

        var requestBody = SendEmailRequest(email: email ?? '');

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            requestBody.toJson(),
          ), // تأكد toJson يرجع Map<String, dynamic>
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var sendEmailResponse = SendEmailResponse.fromJson(jsonResponse);
          return right(sendEmailResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }

  Future<Either<LoginError, ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest request,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.resetPassApi);

        print('Sending reset password request to: $url');
        print('Request body: ${request.toJson()}');

        var response = await http.post(
          url,
          body: jsonEncode(request.toJson()), // مهم هنا برضو jsonEncode
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final resetPassResponse = ResetPasswordResponse.fromJson(
            jsonResponse,
          );
          return right(resetPassResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
              // details: "Please check your connection and try again.",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: -1,
            message: "Unexpected Error",
            // details: e.toString(),
          ),
        ),
      );
    }
  }


  Future<Either<LoginError, ChangePaswwordResponse>> changePassword(
      String email,
      String code,
      String newPassword,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.changePassApi);

        var requestBody = ChangePasswordRequest(
          email: email ?? '',
          code: code ?? '',
          newPassword: newPassword ?? '',
        );

        print('Sending request to: $url');
        print('Request body: ${requestBody.toJson()}');

        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            requestBody.toJson(),
          ), // تأكد toJson يرجع Map<String, dynamic>
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var changePassResponse = ChangePaswwordResponse.fromJson(
            jsonResponse,
          );
          return right(changePassResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }

  Future<Either<LoginError, VerifyEmailResponse>> verifyEmail(
      VerifyEmailRequest request,
      ) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.verifyEmailApi);

        print('Sending Verify Email request to: $url');
        print('Request body: ${request.toJson()}');

        var response = await http.post(
          url,
          body: jsonEncode(request.toJson()), // مهم هنا برضو jsonEncode
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final verifyResponse = VerifyEmailResponse.fromJson(jsonResponse);
          return right(verifyResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
              // details: "Please check your connection and try again.",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: -1,
            message: "Unexpected Error",
            // details: e.toString(),
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, GoogleResponse>> googleLogin(String token , String role) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        // الـ endpoint لازم يحدد من الباك
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.googleLoginApi);

        var requestBody = {
          "token": token, // ده اللي جاي من GoogleSignIn
          "role":role,
        };

        print('Sending Google Login request to: $url');
        print('Request body: $requestBody');

        var response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(requestBody),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          var googleResponse = GoogleResponse.fromJson(jsonResponse);
          return right(googleResponse);
        }
        else {
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش إنترنت
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception in Google Login: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(code: -1, message: "Unexpected Error"),
        ),
      );
    }
  }

  Future<Either<LoginError, AllCategoriesResponse>> getAllCategories() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.getCategories);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var levelResponse = AllCategoriesResponse.fromJson(jsonResponse);

        return right(levelResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
            // details: "Please check your connection and try again.",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, AllBooksResponse>> getAllBooks() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.getBooksApi);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var bookResponse = AllBooksResponse.fromJson(jsonResponse);

        return right(bookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
            // details: "Please check your connection and try again.",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, BookByIdResponse>> getBookByID(String bookId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/user/books/$bookId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $savedToken",
          "Content-Type": "application/json",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bookResponse = BookByIdResponse.fromJson(jsonResponse);
        return right(bookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, BooksByCategoryIdResponse>> getBookByCategoryID(String categoryId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/user/categories/$categoryId/books");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bookResponse = BooksByCategoryIdResponse.fromJson(jsonResponse);
        return right(bookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, ReviewResponse>> writeReview(ReviewRequest request) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.reviewApi);

        print('Sending Verify Email request to: $url');
        print('Request body: ${request.toJson()}');

        final savedToken = await TokenStorage.getToken();

        if (savedToken == null) {
          print("⚠️ No auth token saved, user might not be logged in.");
          return left(
            LoginError(
              success: false,
              error: LoginDetailsError(
                code: 401,
                message: "Unauthorized: No token found, please login again.",
              ),
            ),
          );
        }

        var response = await http.post(
          url,
          body: jsonEncode(request.toJson()), // مهم هنا برضو jsonEncode


          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $savedToken",

          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final reviewResponse = ReviewResponse.fromJson(jsonResponse);
          return right(reviewResponse);
        } else {
          // أخطاء السيرفر
          return left(LoginError.fromJson(jsonResponse));
        }
      } else {
        // مفيش انترنت
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 0,
              message: "No Internet Connection",
              // details: "Please check your connection and try again.",
            ),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: -1,
            message: "Unexpected Error",
            // details: e.toString(),
          ),
        ),
      );
    }
  }


  Future<Either<LoginError, BookReviewResponse>> getBookReview(String bookId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/user/book-reviews/book/$bookId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var bookReviewResponse = BookReviewResponse.fromJson(jsonResponse);
        return right(bookReviewResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }


  Future<Either<LoginError, SaveBookResponse>> saveBook(SaveBookRequest request) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.saveBookApi);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
        body: jsonEncode(request.toJson()), // ⬅ هنا

      );


      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var saveBookResponse = SaveBookResponse.fromJson(jsonResponse);
        return right(saveBookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, AllSavedBooksResponse>> getSaveBooks() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.getSaveBookApi);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var allSavedBooksResponse = AllSavedBooksResponse.fromJson(jsonResponse);

        return right(allSavedBooksResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
            // details: "Please check your connection and try again.",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, RemoveSavedBook>> removeSavedBooks(String bookId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, '/api/user/favorite-books/$bookId');

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var removeSavedBookResponse = RemoveSavedBook.fromJson(jsonResponse);

        return right(removeSavedBookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
            // details: "Please check your connection and try again.",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, CategoryByIdResponse>> getCategoryByID(String parentId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, "/api/user/categories/$parentId");

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",
        },
      );

      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var categoryByIdResponse = CategoryByIdResponse.fromJson(jsonResponse);
        return right(categoryByIdResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, SearchResponse>> searchBooks(String query) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {

      // ⬅️ نبني الـ URL مع query parameter
      Uri url = Uri.https(
        ApiConstants.baseurl,
        "/api/user/books/search/",
        {"query": query}, // هنا الـ Query Parameters
      );

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      // ⬅️ إرسال request
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",
        },
      );

      print("📡 Search status: ${response.statusCode}");
      print("📦 Search body: ${response.body}");

      var jsonResponse = jsonDecode(response.body);

      // ⬅️ في حالة نجاح
      if (response.statusCode >= 200 && response.statusCode < 300) {
        var searchResponse = SearchResponse.fromJson(jsonResponse);
        return right(searchResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, BorrowResponse>> borrowBook(String bookId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, '/api/user/borrows/$bookId');

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },

      );


      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var borrowBookResponse = BorrowResponse.fromJson(jsonResponse);
        return right(borrowBookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, GetBorrowResponse>> getBorrowBooks() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.borrowApi);

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        /// هنا بعمل parse للـ object كله
        var borrowBooksResponse = GetBorrowResponse.fromJson(jsonResponse);

        return right(borrowBooksResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
            // details: "Please check your connection and try again.",
          ),
        ),
      );
    }
  }

  Future<Either<LoginError, ReturnResponse>> returnBook(String borrowId) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Uri url = Uri.https(ApiConstants.baseurl, '/api/user/borrows/return/$borrowId');

      final savedToken = await TokenStorage.getToken();

      if (savedToken == null) {
        print("⚠️ No auth token saved, user might not be logged in.");
        return left(
          LoginError(
            success: false,
            error: LoginDetailsError(
              code: 401,
              message: "Unauthorized: No token found, please login again.",
            ),
          ),
        );
      }

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $savedToken",

        },

      );


      print('Mark as read status: ${response.statusCode}');
      print('Mark as read body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var returnBookResponse = ReturnResponse.fromJson(jsonResponse);
        return right(returnBookResponse);
      } else {
        return left(LoginError.fromJson(jsonResponse));
      }
    } else {
      return left(
        LoginError(
          success: false,
          error: LoginDetailsError(
            code: 0,
            message: "No Internet Connection",
          ),
        ),
      );
    }
  }







}