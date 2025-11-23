import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool isChecked = false;
  bool isDarkMode = false;


  File? image;
  //final ImagePicker _picker = ImagePicker();
  String? profileImageUrl;

  String? userRole;

  bool showField = false;
  bool showDropdown = false;
  bool showDropdownlocation = false;



  final List<String> gender = [
    "male",
    "female",
  ];




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
        if (user.baseImage64 != null && user.baseImage64!.isNotEmpty) {
          profileImageUrl = "${user.baseImage64 }?t=${DateTime.now().millisecondsSinceEpoch}";
        } else {
          profileImageUrl = "assets/images/userProfile.png";
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












// Future<void> updateProfile() async {
  //   if (!formKey.currentState!.validate()) return;
  //   emit(LoadingState(loadingMessage: 'جارٍ تحديث البيانات...'));
  //
  //   // 🔹 رفع الصورة لو فيه
  //   String? uploadedImageUrl;
  //   if (image != null) {
  //     try {
  //       final bytes = await image!.readAsBytes();
  //       final base64Image = base64Encode(bytes);
  //       final request = ImageRequest(baseImage64: "data:image/png;base64,$base64Image");
  //       final either = await repository.uploadProfileImage(request);
  //       await either.fold(
  //             (failure) async {
  //           emit(ErrorState(errorMessage: failure.error?.message ?? "فشل في رفع الصورة"));
  //         },
  //             (response) async {
  //           uploadedImageUrl = response.data?.imageUrl;
  //           if (uploadedImageUrl != null && uploadedImageUrl!.isNotEmpty) {
  //             profileImageUrl = uploadedImageUrl!;
  //           }
  //         },
  //       );
  //     } catch (e) {
  //       emit(ErrorState(errorMessage: "حدث خطأ أثناء رفع الصورة: $e"));
  //       return;
  //     }
  //   }
  //
  //   // 🔹 بناء الريكويست حسب النوع
  //   UpdateProfileRequest request;
  //
  //   if (isGraduated) {
  //     // 💡 هنا التعديل المهم:
  //     String? employmentStatusAr = selectedEmploymentStatus;
  //     String employmentStatusEn = mapArEmploymentStatus(employmentStatusAr);
  //
  //     // لو الحالة مش "موظف" امسح بيانات الوظيفة فقط (سيب الـ CV)
  //     if (employmentStatusAr != "موظف") {
  //       jobTitleController.text = "";
  //       companyLocationController.text = "";
  //       companyLinkController.text = "";
  //     }
  //
  //     request = UpdateProfileRequest(
  //       name: userNameController.text.trim(),
  //       email: emailController.text.trim(),
  //       department: departmentController.text.trim(),
  //       graduatedData: GraduatedData(
  //         cv: resumeFile, // 🟢 دايماً يتبعت زي ما هو
  //         employmentStatus: employmentStatusEn,
  //         jobTitle: jobTitleController.text.trim().isEmpty
  //             ? null
  //             : jobTitleController.text.trim(),
  //         companyLocation: companyLocationController.text.trim().isEmpty
  //             ? null
  //             : companyLocationController.text.trim(),
  //         companyLink: companyLinkController.text.trim().isEmpty
  //             ? null
  //             : companyLinkController.text.trim(),
  //       ),
  //     );
  //   } else {
  //     request = UpdateProfileRequest(
  //       name: userNameController.text.trim(),
  //       email: emailController.text.trim(),
  //       level: int.tryParse(levelController.text.trim()) ?? 1,
  //       department: departmentController.text.trim(),
  //     );
  //   }
  //
  //   // 📡 إرسال الطلب
  //   var either = await repository.updateData(request);
  //
  //   either.fold(
  //         (failure) {
  //       emit(ErrorState(errorMessage: failure.error?.message ?? "حدث خطأ أثناء التحديث"));
  //     },
  //         (response) async {
  //       emit(UpdateProfileSuccessState(userUpdate: response.data!.user!));
  //       userNameController.text = response.data!.user!.name ?? '';
  //       emailController.text = response.data!.user!.email ?? '';
  //
  //       if (response.data!.user!.graduatedData != null) {
  //         final grad = response.data!.user!.graduatedData!;
  //         employmentStatusController.text = mapEmploymentStatus(grad.employmentStatus ?? '');
  //         jobTitleController.text = grad.jobTitle ?? '';
  //         companyLocationController.text = grad.companyLocation ?? '';
  //         companyLinkController.text = grad.companyLink ?? '';
  //         // cvController.text = grad.cv != null
  //         //     ? grad.cv!
  //         //     : cvUrl ?? '';
  //         if (grad.cv != null && grad.cv!.isNotEmpty) {
  //           cvUrl = grad.cv;
  //           cvFileName = grad.cv!.split('/').last; // 🟢 آخر جزء فقط من اللينك
  //           cvController.text = cvFileName!;
  //         } else {
  //           cvUrl = null;
  //           cvController.text = 'لا يوجد ملف سيرة ذاتية';
  //         }
  //
  //
  //       }
  //
  //       isEditable = false;
  //       await getProfile();
  //     },
  //   );
  // }
  //
  // Future<void> pickProfileImage() async {
  //   try {
  //     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //     if (pickedFile == null) return;
  //
  //     image = File(pickedFile.path);
  //     profileImageUrl = image!.path; // ← تخليها تظهر فورًا في الـ UI
  //     emit(UploadImageSuccessState(profileImageUrl ?? ""));
  //   } catch (e) {
  //     emit(ErrorState(errorMessage: "حدث خطأ أثناء اختيار الصورة: $e"));
  //   }
  // }
  // Future<void> deleteProfile(BuildContext context) async {
  //   emit(LoadingState(loadingMessage: 'جارٍ حذف الحساب...'));
  //
  //   final either = await repository.deleteProfile();
  //
  //   await either.fold(
  //         (failure) {
  //       emit(ErrorState(errorMessage: failure.error?.message ?? "حدث خطأ أثناء حذف الحساب"));
  //     },
  //         (response) async {
  //       // 🧹 مسح البيانات المحلية
  //       final prefs = await SharedPreferences.getInstance();
  //       await prefs.clear();
  //
  //       Navigator.pushReplacementNamed(context, account_type.routeName);
  //       // 🟢 إظهار رسالة نجاح
  //       emit(DeleteProfileSuccessState(response));
  //
  //     },
  //   );
  // }
  //
  // void clearData() {
  //   // مسح كل البيانات المؤقتة في الذاكرة
  //   userNameController.clear();
  //   emailController.clear();
  //   levelController.clear();
  //   departmentController.clear();
  //   languageController.clear();
  //
  //   profileImageUrl = null;
  //   image = null;
  //   isEditable = false;
  //
  //   emit(InitialState()); // نرجّع الحالة للبداية
  // }
  //
  //
  // Future<void> logout(BuildContext context) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  //
  //   // 🧠 امسحي بيانات البروفايل
  //   context.read<ProfileViewModel>().clearData();
  //
  //   // ✅ امسحي بيانات الشات
  //   try {
  //     final chatCubit = context.read<ChatCubit>();
  //     chatCubit.disconnect(); // يفصل السوكت القديم
  //     await chatCubit.close();
  //   } catch (e) {
  //     debugPrint("⚠️ ChatCubit not found — skipping cleanup");
  //   }
  //
  //   // 🚪 رجّعي المستخدم لشاشة اختيار الحساب
  //   Navigator.pushNamedAndRemoveUntil(
  //     context,
  //     account_type.routeName,
  //         (route) => false,
  //   );
  // }





}
