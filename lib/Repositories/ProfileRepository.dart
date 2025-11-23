import 'package:dartz/dartz.dart';

import '../Models/Responses/LoginError.dart';
import '../Models/Responses/ProfileResponse.dart';
import '../Sources/ProfiledataSource.dart';

class ProfileRepository {
  final ProfileDataSource remoteDataSource;

  ProfileRepository(this.remoteDataSource);

  Future<Either<LoginError, ProfileResponse>> getProfile() {
    return remoteDataSource.getProfile();
  }

  // Future<Either<LoginError, UpdateProfile>> updateData(UpdateProfileRequest request ) {
  //   return remoteDataSource.updateData(request);
  // }
  //
  //
  //
  //
  // Future<Either<LoginError, DeleteProfileResponse>> deleteProfile() {
  //   return remoteDataSource.deleteProfile();
  // }
}
