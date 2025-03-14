import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:socialmedia_app/features/profile/presentation/pages/edit_profile.dart';

class MyProfile extends StatefulWidget {
  final String uid;
  const MyProfile({super.key, required this.uid});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return Text(state.profileUser.name);
            }
            return const Text("Profile");
          },
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditProfile(profileUser: state.profileUser),
                      ),
                    );
                  },
                );
              }
              return const SizedBox(); // Return empty widget when profile is not loaded
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final user = state.profileUser;

            // Sample image URLs (Replace with Firestore image links)
            final List<String> postImages = [
              "https://images.unsplash.com/photo-1740482801914-6b6b928ba062?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              "https://images.unsplash.com/photo-1740417643401-94dcd72ca0fb?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              "https://images.unsplash.com/photo-1740522620382-f91c18a2cb28?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              "https://images.unsplash.com/photo-1739993655680-4b7050ed2896?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyNzF8fHxlbnwwfHx8fHw%3D",
              "https://plus.unsplash.com/premium_photo-1690406382383-3827c1397c48?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              "https://images.unsplash.com/photo-1737995719929-6e759e679172?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ];

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Card
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Profile Picture
                        Container(
                          padding: EdgeInsets.all(
                              4), // Space between border and avatar
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.green,
                                Colors.black
                              ], // Gradient colors
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 58, // Slightly smaller than border
                            backgroundColor:
                                Colors.white, // Optional white background
                            backgroundImage: user.profileImageUrl.isNotEmpty
                                ? NetworkImage(user.profileImageUrl)
                                : const NetworkImage(
                                    'https://images.unsplash.com/photo-1740158908172-d1fd95302fad?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // User Name
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),

                        // User Email
                        Text(
                          user.email,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Bio Section inside a white bordered container
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Text(
                            user.bio.isNotEmpty
                                ? user.bio
                                : "No bio available.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  // Posts Section
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      "Posts",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Grid of Images
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3 images per row
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: postImages.length, // Replace with dynamic count
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Implement image fullscreen preview
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            postImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const Center(child: Text("No Profile Data Available"));
          }
        },
      ),
    );
  }
}
