/*


Profile Repositories




*/

import 'package:socialmedia_app/features/profile/domain/entites/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> fetchUserProfile(String uid);
  Future<void> updateUserProfile(ProfileUser updatedProfile);
}
