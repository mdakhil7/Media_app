import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia_app/features/profile/domain/entites/profile_user.dart';
import 'package:socialmedia_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:socialmedia_app/widgets/custom_textfield.dart';

class EditProfile extends StatefulWidget {
  final ProfileUser profileUser;
  const EditProfile({super.key, required this.profileUser});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController bioTextController;
  PlatformFile? imagePickedFile;

  @override
  void initState() {
    super.initState();
    bioTextController = TextEditingController(text: widget.profileUser.bio);
  }

  @override
  void dispose() {
    bioTextController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        imagePickedFile = result.files.first;
      });
    }
  }

  void updateProfileBio() {
    final profileCubit = context.read<ProfileCubit>();
    final String uid = widget.profileUser.uid;
    final String? imageMobilePath = imagePickedFile?.path;
    final String? newBio = bioTextController.text.trim().isNotEmpty
        ? bioTextController.text.trim()
        : null;

    if (newBio == null && imageMobilePath == null) {
      Navigator.pop(context);
      return;
    }

    profileCubit.updateUserProfile(
      uid: uid,
      newBio: newBio,
      newProfileImage: imageMobilePath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        } else if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return _buildUpdateProfile();
      },
    );
  }

  Widget _buildUpdateProfile() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            onPressed: updateProfileBio,
            icon: const Icon(Icons.upload),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image with Gradient Border
            Center(
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.6),
                      blurRadius: 12,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: imagePickedFile != null
                        ? Image.file(File(imagePickedFile!.path!), fit: BoxFit.cover)
                        : CachedNetworkImage(
                            imageUrl: widget.profileUser.profileImageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(
                              Icons.person,
                              size: 80,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // "Pick Image" Button with Gradient Text
            Center(
              child: TextButton(
                onPressed: pickImage,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.black.withOpacity(0.1),
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.green, Colors.grey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'PICK IMAGE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bio Field
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bio',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: bioTextController,
              hintText: 'Enter your bio...',
            ),
          ],
        ),
      ),
    );
  }
}
