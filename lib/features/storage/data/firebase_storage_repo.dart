import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:socialmedia_app/features/storage/domain/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo {
  final FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Future<String?> uplaodProfileImage(String path, String fileName) async {
    try {
      File file = File(path);
      final Reference ref = storage.ref().child('profile_images/$fileName');
      final UploadTask uploadTask = ref.putFile(file);

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print("Error uploading profile image: $e");
      return null;
    }
  }
}
