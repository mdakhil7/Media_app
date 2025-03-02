import 'package:socialmedia_app/features/auth/domain/entites/user_app.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageUrl;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.name,
    required this.bio,
    required this.profileImageUrl,
  });

  // Method for updating the profile user
  ProfileUser copyWith({
    String? newBio,
    String? newProfileImageUrl,
  }) {
    return ProfileUser(
      uid: uid,
      email: email,
      name: name,
      bio: newBio ?? bio,
      profileImageUrl: newProfileImageUrl ?? profileImageUrl,
    );
  }

  // Convert ProfileUser to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
    };
  }

  // Create ProfileUser from JSON
  // factory ProfileUser.fromJson(Map<String, dynamic> json) {
  //   return ProfileUser(
  //     uid: json['uid'],
  //     email: json['email'],
  //     name: json['name'],
  //     bio: json['bio'] ?? '',
  //     profileImageUrl: json['profileImageUrl'] ?? '',
  //   );
  // }
  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      uid: json['uid'] ?? '', // ✅ Default empty string if null
      email: json['email'] ?? 'No Email',
      name: json['name'] ?? 'Unknown',
      bio: json['bio'] ?? '', // ✅ Ensures bio is always a String
      profileImageUrl: json['profileImageUrl'] ?? '', // ✅ Prevents null error
    );
  }

  // Override toString() for debugging
  @override
  String toString() {
    return 'ProfileUser(uid: $uid, email: $email, name: $name, bio: $bio, profileImageUrl: $profileImageUrl)';
  }
}
