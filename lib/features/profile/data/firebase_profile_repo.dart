import 'package:socialmedia_app/features/profile/domain/entites/profile_user.dart';
import 'package:socialmedia_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  @override
  // Future<ProfileUser?> fetchUserProfile(String uid) async {
  //   try {
  //     // Get user document from Firebase
  //     final userDoc = await firebaseFireStore.collection('users').doc(uid).get();

  //     if (userDoc.exists) {
  //       final userData = userDoc.data();
  //       if (userData != null) {
  //         return ProfileUser(
  //           uid: uid,
  //           email: userData['email'],
  //           name: userData['name'],
  //           bio: userData['bio'],
  //           profileImageUrl: userData['profileImageUrl'].toString(),
  //         );
  //       }
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Error fetching user profile: $e');
  //     return null;
  //   }
  // }

  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      print("Querying Firestore for UID: $uid");

      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        print("User Data Found: ${userDoc.data()}"); // ✅ Debugging output

        return ProfileUser.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        print("Firestore: No user found for UID: $uid");
        return null;
      }
    } catch (e) {
      print("Firestore Error: $e");
      return null;
    }
  }

  @override
  Future<void> updateUserProfile(ProfileUser updatedUser) async {
    try {
      await firebaseFireStore.collection('users').doc(updatedUser.uid).update({
        'name': updatedUser.name,
        'bio': updatedUser.bio,
        'profileImageUrl': updatedUser.profileImageUrl,
      });
    } catch (e) {
      print('Error updating user profile: $e');
      throw Exception('Failed to update profile');
    }
  }
}
