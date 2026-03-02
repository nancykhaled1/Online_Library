import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_library_app/View/Auth/Login/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Requests/UpdateProfileRequest.dart';
import '../../Repositories/ProfileRepository.dart';
import '../States/States.dart';


class ProfileViewModel extends Cubit<States> {
  final ProfileRepository repository;

  ProfileViewModel(this.repository) : super(InitialState());

  var formKey = GlobalKey<FormState>();
  var profileFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  bool showDropdownlevel = false;

  File? image;
  final ImagePicker _picker = ImagePicker();
  String? profileImageUrl;


  List<String> genders = ["male", "female"];



  bool isEditable = false;
  void toggleEdit() {
    isEditable = !isEditable;
    emit(ChangeEditState());
  }




  final List<String> gender = [
    "male",
    "female",
  ];

  String? pickedBase64Image;



  Future<void> getProfile() async {
    emit(LoadingState(loadingMessage: 'Loading...'));

    var either = await repository.getProfile();

    either.fold(
          (failure) {
        emit(ErrorState(errorMessage: failure.error?.message ?? "Error"));
      },
          (response) async {
        final user = response.data?.user;

        // حماية من الـ null
        if (user == null) {
          emit(ErrorState(errorMessage: "User data is empty"));
          return;
        }

        // تحميل صورة البروفايل
        if (user.photo != null && user.photo!.isNotEmpty) {
          profileImageUrl = "${user.photo }?t=${DateTime.now().millisecondsSinceEpoch}";
        } else {
          profileImageUrl = "assets/images/personalImage.png";
        }

        // تعبئة الكنترولرز
        userNameController.text = user.name ?? '';
        emailController.text = user.email ?? '';
        phoneController.text = user.phone ?? '';
        genderController.text = user.gender ?? '';

        emit(ProfileSuccessState(user: user));
      },
    );
  }


  Future<void> updateProfile() async {
    emit(LoadingState(loadingMessage: "Updating..."));

    try {
      String? base64Image = pickedBase64Image;

      /// جسم الريكويست الصحيح
      Map<String, dynamic> finalBody = {
        "name": userNameController.text.trim(),
        "phone": phoneController.text.trim(),
        "email": emailController.text.trim(),
        "gender": genderController.text.trim(),
      };

      /// لو في صورة → نبعتها تحت الفيلد اللي الباك إند عايزه
      if (base64Image != null) {
        finalBody["image"] = "data:image/png;base64,$base64Image";
      }

      print("FINAL REQUEST → $finalBody");

      var either = await repository.updateData(finalBody);

      either.fold(
            (failure) {
          emit(ErrorState(errorMessage: failure.error?.message ?? "Update Failed"));
        },
            (response) {
          profileImageUrl = response.data?.user?.photo;
          isEditable = false;

          emit(UpdateProfileSuccessState(user: response.data!.user!));
          emit(ChangeEditState());
        },
      );
    } catch (e) {
      emit(ErrorState(errorMessage: "Error occurred: $e"));
    }
  }



  Future<void> pickProfileImage() async {
    try {
      // 1) اختيار الصورة
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile == null) {
        emit(ErrorState(errorMessage: "لم يتم اختيار أي صورة"));
        return;
      }

      // 2) تحويله لـ File
      image = File(pickedFile.path);

      // 3) تحويلها Base64
      final bytes = await image!.readAsBytes();
      pickedBase64Image = base64Encode(bytes);

      // 4) تحديث UI
      profileImageUrl = image!.path;

      emit(UploadImageSuccessState(profileImageUrl!));

    } catch (e) {
      emit(ErrorState(errorMessage: "حدث خطأ أثناء اختيار الصورة: $e"));
    }
  }


  Future<void> deleteProfile(BuildContext context) async {
    emit(LoadingState(loadingMessage: 'جارٍ حذف الحساب...'));

    final either = await repository.deleteProfile();

    await either.fold(
          (failure) {
        emit(ErrorState(errorMessage: failure.error?.message ?? "حدث خطأ أثناء حذف الحساب"));
      },
          (response) async {
        // 🧹 مسح البيانات المحلية
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        // 🟢 إظهار رسالة نجاح
        emit(DeleteProfileSuccessState(response));

      },
    );
  }

  void clearData() {
    // مسح كل البيانات المؤقتة في الذاكرة
    userNameController.clear();
    emailController.clear();
    genderController.clear();
    phoneController.clear();

    profileImageUrl = null;
    image = null;
    isEditable = false;

    emit(InitialState()); // نرجّع الحالة للبداية
  }


  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // 🧠 امسحي بيانات البروفايل
    context.read<ProfileViewModel>().clearData();


    // 🚪 رجّعي المستخدم لشاشة اختيار الحساب
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
          (route) => false,
    );
  }





}
