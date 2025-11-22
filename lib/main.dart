







import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_library_app/Cubit/Home/BookViewModel.dart';
import 'package:online_library_app/Cubit/Home/CategoryViewModel.dart';
import 'package:online_library_app/Cubit/Home/ReviewViewModel.dart';
import 'package:online_library_app/Cubit/MyShelf/BorrowViewModel.dart';
import 'package:online_library_app/Cubit/MyShelf/SaveListViewModel.dart';
import 'package:online_library_app/Cubit/Search/SearchScreenViewModel.dart';
import 'package:online_library_app/Repositories/BorrowRepository.dart';
import 'package:online_library_app/Repositories/ReturnRepository.dart';
import 'package:online_library_app/Repositories/SaveBookRepository.dart';
import 'package:online_library_app/Repositories/SearchRepository.dart';
import 'package:online_library_app/Sources/BorrowDataSource.dart';
import 'package:online_library_app/Sources/ReturnDataSource.dart';
import 'package:online_library_app/Sources/SaveBookDataSource.dart';
import 'package:online_library_app/Sources/SearchDataSource.dart';

import 'Cubit/Auth/Login/LoginScreenViewModel.dart';
import 'Cubit/Auth/Login/SendCodeViewModel.dart';
import 'Cubit/Auth/Login/forget_passViewModel.dart';
import 'Cubit/Auth/Login/re-passViewModel.dart';
import 'Cubit/Auth/Register/GoogleViewModel.dart';
import 'Cubit/Auth/Register/RegisterViewModel.dart';
import 'Cubit/Auth/Register/VerifyemailViewModel.dart';
import 'Cubit/Home/HomeScreenViewModel.dart';
import 'Cubit/MyShelf/ReturnViewModel.dart';
import 'Repositories/AllCategoriesRepository.dart';
import 'Repositories/ChangePasswordRepository.dart';
import 'Repositories/GoogleRepository.dart';
import 'Repositories/LoginRepository.dart';
import 'Repositories/RegisterRepository.dart';
import 'Repositories/ResetPasswordRepository.dart';
import 'Repositories/SendEmailRepository.dart';
import 'Repositories/VerifyEmailRepository.dart';
import 'Services/Remote/ApiManager.dart';
import 'Sources/AllCategoriesDataSource.dart';
import 'Sources/ChangePasswordDataSource.dart';
import 'Sources/GoogleDataSource.dart';
import 'Sources/LoginDataSource.dart';
import 'Sources/RegisterDataSource.dart';
import 'Sources/ResetPasswordDataSource.dart';
import 'Sources/SendEmailDataSource.dart';
import 'Sources/VerifyEmailDataSource.dart';
import 'Utils/MyColors.dart';
import 'View/Auth/Login/LoginScreen.dart';
import 'View/Auth/Login/SendEmailScreen.dart';
import 'View/Auth/Register/RegisterScreen.dart';
import 'View/Home/LibraryHomeScreen.dart';
import 'View/Home/home.dart';

Future<void> main() async {
  final apiManager = ApiManager();
  final registerRemoteDataSource = RegisterRemoteDataSource(apiManager );
  final registerRepository = RegisterRepository(registerRemoteDataSource);



  final verifyEmailRemoteDataSource = VerifyEmailRemoteDataSource(apiManager);
  final verifyEmail = VerifyEmailRepository(verifyEmailRemoteDataSource);

  //login
  final loginRemoteDataSource = LoginRemoteDataSource(apiManager);
  final loginRepository = LoginRepository(loginRemoteDataSource);

  //sendemail
  final sendEmailRemoteDataSource = SendEmailRemoteDataSource(apiManager);
  final sendEmail = SendEmailRepository(sendEmailRemoteDataSource);

  //sendcode
  final resetPasswordRemoteDataSource = ResetPasswordRemoteDataSource(apiManager);
  final sendCode = ResetPasswordRepository(resetPasswordRemoteDataSource);

  //changepass
  final changePassRemoteDataSource = ChangePassRemoteDataSource(apiManager);
  final changePass = ChangePasswordRepository(changePassRemoteDataSource);

  //google
  final googleDataSource = GoogleDataSource(apiManager);
  final google = GoogleRepository(googleDataSource);

  //Categories
  final allCategoriesDataSource = AllCategoriesRemoteDataSource(apiManager);
  final allCategories = AllCategoriesRepository(allCategoriesDataSource);

  //save
  final saveBookDataSource = SaveBookRemoteDataSource(apiManager);
  final saveBook = SaveBookRepository(saveBookDataSource);

  //search
  final searchBookDataSource = SearchRemoteDataSource(apiManager);
  final search = SearchRepository(searchBookDataSource);

  //borrow
  final borrowBookDataSource = BorrowRemoteDataSource(apiManager);
  final borrow = BorrowRepository(borrowBookDataSource);

  //borrow
  final returnBookDataSource = ReturnRemoteDataSource(apiManager);
  final returned = ReturnRepository(returnBookDataSource);

  runApp(

    MultiRepositoryProvider(
      providers: [


        RepositoryProvider<RegisterRepository>(
          create: (context) => registerRepository,
        ),


        RepositoryProvider<VerifyEmailRepository>(
          create: (context) => verifyEmail,
        ),

        RepositoryProvider<LoginRepository>(
          create: (context) => loginRepository,
        ),

        RepositoryProvider<SendEmailRepository>(
          create: (context) => sendEmail,
        ),

        RepositoryProvider<ResetPasswordRepository>(
          create: (context) => sendCode,
        ),

        RepositoryProvider<ChangePasswordRepository>(
          create: (context) => changePass,
        ),

        RepositoryProvider<GoogleRepository>(
          create: (context) => google,
        ),

        RepositoryProvider<AllCategoriesRepository>(
          create: (context) => allCategories,
        ),

        RepositoryProvider<SaveBookRepository>(
          create: (context) => saveBook,
        ),

        RepositoryProvider<SearchRepository>(
          create: (context) => search,
        ),
        RepositoryProvider<BorrowRepository>(
          create: (context) => borrow,
        ),

        RepositoryProvider<ReturnRepository>(
          create: (context) => returned,
        ),



      ],

      child: MultiBlocProvider(
        providers: [

          BlocProvider(
            create: (context) => RegisterCubit(
              context.read<RegisterRepository>(),
            ),
          ),



          BlocProvider(
            create: (context) => VerifyEmailCubit(
              context.read<VerifyEmailRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => LoginScreenCubit(
              context.read<LoginRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => ForgetPassScreenCubit(
              context.read<SendEmailRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => SendCodeCubit(
              context.read<ResetPasswordRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => RePasswordCubit(
              context.read<ChangePasswordRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => GoogleCubit(
              context.read<GoogleRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => HomeScreenCubit(
              context.read<AllCategoriesRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => CategoryCubit(
              context.read<AllCategoriesRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => ReviewCubit(
              context.read<AllCategoriesRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => SaveListCubit(
              context.read<SaveBookRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => BookCubit(
              context.read<AllCategoriesRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => SearchScreenCubit(
              context.read<SearchRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => BorrowCubit(
              context.read<BorrowRepository>(),
            ),
          ),

          BlocProvider(
            create: (context) => ReturnedCubit(
              context.read<ReturnRepository>(),
            ),
          ),


        ],
        child: const MyApp(),
      ),
    ),


  );
}





class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (_, child) {
        return SafeArea(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primaryColor: MyColors.primaryColor,
                colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColor),

              ),

              // locale: Locale('ar', ''),
              // supportedLocales: [Locale('ar', ''), Locale('en', '')],
              // localizationsDelegates: [
              //   GlobalMaterialLocalizations.delegate,
              //   GlobalWidgetsLocalizations.delegate,
              //   GlobalCupertinoLocalizations.delegate,
              // ],

              initialRoute: LoginScreen.routeName,
              routes: {
                LoginScreen.routeName : (context) => LoginScreen(),
                SendEmailScreen.routeName : (context) => SendEmailScreen(),
                HomeScreen.routeName : (context) => HomeScreen(),
                RegisterScreen.routeName : (context) => RegisterScreen(),
                LibraryHomeScreen.routeName : (context) => LibraryHomeScreen(),
               // MyShelfScreen.routeName : (context) => MyShelfScreen()
              }


          ),
        );
      },
    );
  }
}
