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
  // Bio Controller
  late TextEditingController bioTextController;

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

  // Function for updating bio
  void updateProfileBio() {
    final profileCubit = context.read<ProfileCubit>();
    if (bioTextController.text.trim().isNotEmpty) {
      profileCubit.updateUserProfile(
        uid: widget.profileUser.uid,
        newBio: bioTextController.text.trim(),
      );
    }
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bio',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
