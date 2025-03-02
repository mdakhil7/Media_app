import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia_app/features/profile/domain/entites/profile_user.dart';
import 'package:socialmedia_app/features/profile/domain/repositories/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  // Fetch user profile
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User not found'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Update user profile
  Future<void> updateUserProfile({required String uid, String? newBio}) async {
    emit(ProfileLoading());

    try {
      // Fetch profile
      final currentUser = await profileRepo.fetchUserProfile(uid);

      if (currentUser == null) {
        emit(ProfileError('Failed to fetch user for profile update'));
        return; // ✅ Stops execution if user not found
      }

      final updatedProfile = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio, // ✅ Use correct parameter name
      );

      await profileRepo.updateUserProfile(updatedProfile);
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError('Failed to update profile: ${e.toString()}'));
    }
  }
}
