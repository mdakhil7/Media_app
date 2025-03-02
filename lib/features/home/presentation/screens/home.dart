import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:socialmedia_app/features/home/presentation/widgets/custom_tile.dart';
import 'package:socialmedia_app/features/profile/presentation/pages/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Icon(
              Icons.person,
              size: 80,
            ),
            Divider(),
            Column(
              children: [
                CustomTileDrawer(
                  title: 'HOME',
                  icon: Icons.home,
                  onTap: () => Navigator.pop(context),
                ),
                CustomTileDrawer(
                  title: 'PROFILE',
                  icon: Icons.person_4,
                  onTap: () {
                    Navigator.pop(context);

                    final user = context.read<AuthCubit>().currentUser;
                    String? uid = user!.uid;
                    print(uid);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyProfile(uid: uid),
                      ),
                    );
                  },
                ),
                CustomTileDrawer(
                  title: 'SUPPORT',
                  icon: Icons.help,
                ),
                CustomTileDrawer(
                  title: 'SETTING',
                  icon: Icons.settings,
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CustomTileDrawer(
                icon: Icons.logout,
                title: 'LOGOUT',
                onTap: () {
                  context.read<AuthCubit>().logout();
                },
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Hey'),
      ),
    );
  }
}
