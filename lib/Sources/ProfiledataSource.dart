import 'package:dartz/dartz.dart';

import '../Models/Responses/LoginError.dart';
import '../Models/Responses/ProfileResponse.dart';
import '../Services/Remote/ApiManager.dart';

class ProfileDataSource {
  final ApiManager apiManager;

  ProfileDataSource(this.apiManager);

  Future<Either<LoginError, ProfileResponse>> getProfile() {
    return apiManager.getProfile();
  }

  // Future<Either<LoginError, UpdateProfile>> updateData(UpdateProfileRequest request ) {
  //   return apiManager.updateData(request);
  // }
  //
  //
  // Future<Either<LoginError, DeleteProfileResponse>> deleteProfile() {
  //   return apiManager.deleteProfile();
  // }
}