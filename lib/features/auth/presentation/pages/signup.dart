// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:socialmedia_app/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:socialmedia_app/widgets/custom_button.dart';
// import 'package:socialmedia_app/widgets/custom_textfield.dart';

// class RegisterPage extends StatelessWidget {
//   final void Function()? toggles;
//   RegisterPage({
//     super.key,
//     required this.toggles,
//   });

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     void signUp() {
//       final String email = emailController.text.trim();
//       final String password = passwordController.text.trim();
//       final String confirm = confirmPasswordController.text.trim();
//       final String name = nameController.text.trim();

//       final AuthCubit authCubit = context.read<AuthCubit>();

//       // Email Validation
//       final emailRegex = RegExp(
//           r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
//       if (!emailRegex.hasMatch(email)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Invalid email format')),
//         );
//         return;
//       }

//       if (email.isNotEmpty &&
//           password.isNotEmpty &&
//           name.isNotEmpty &&
//           confirm.isNotEmpty) {
//         if (password == confirm) {
//           authCubit.registerUser(
//             name,
//             email,
//             password,
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Passwords do not match')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('All fields are required')),
//         );
//       }
//     }

//     return Scaffold(
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.white, Colors.grey],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Let’s Get You Started!",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   const Text(
//                     "Join us and explore a world of possibilities!",
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 30),

//                   // Name Field
//                   CustomTextField(
//                     hintText: "Your Name",
//                     controller: nameController,
//                     keyboardType: TextInputType.name,
//                     prefixIcon: Icons.person,
//                   ),
//                   const SizedBox(height: 15),

//                   // Email Field
//                   CustomTextField(
//                     hintText: "Your Email",
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     prefixIcon: Icons.email_outlined,
//                   ),
//                   const SizedBox(height: 15),

//                   // Password Field
//                   CustomTextField(
//                     hintText: "Create a Password",
//                     controller: passwordController,
//                     isPassword: true,
//                     prefixIcon: Icons.lock_outline,
//                   ),
//                   const SizedBox(height: 15),

//                   // Confirm Password Field
//                   CustomTextField(
//                     hintText: "Confirm Password",
//                     controller: confirmPasswordController,
//                     isPassword: true,
//                     prefixIcon: Icons.lock_outline,
//                   ),
//                   const SizedBox(height: 20),

//                   // Sign Up Button
//                   AnimatedButton(
//                     text: "Sign Up",
//                     onPressed: () {
//                       FocusScope.of(context).unfocus();
//                       signUp();
//                     },
//                   ),
//                   const SizedBox(height: 20),

//                   // Login Link
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Already part of the family?",
//                           style: TextStyle(color: Colors.black)),
//                       TextButton(
//                         onPressed: toggles,
//                         child: const Text(
//                           "Login",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:socialmedia_app/widgets/custom_button.dart';
import 'package:socialmedia_app/widgets/custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? toggles;
  RegisterPage({super.key, required this.toggles});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    void signUp() {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String confirm = confirmPasswordController.text.trim();
      final String name = nameController.text.trim();

      final AuthCubit authCubit = context.read<AuthCubit>();

      // Email Validation
      final emailRegex = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      if (!emailRegex.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email format')),
        );
        return;
      }

      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          confirm.isNotEmpty) {
        if (password == confirm) {
          authCubit.registerUser(
            name,
            email,
            password,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')),
        );
      }
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.green,],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Let’s Get You Started!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Join us and explore a world of possibilities!",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 30),

                  // Name Field
                  CustomTextField(
                    hintText: "Your Name",
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(height: 15),

                  // Email Field
                  CustomTextField(
                    hintText: "Your Email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 15),

                  // Password Field
                  CustomTextField(
                    hintText: "Create a Password",
                    controller: passwordController,
                    isPassword: true,
                    prefixIcon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 15),

                  // Confirm Password Field
                  CustomTextField(
                    hintText: "Confirm Password",
                    controller: confirmPasswordController,
                    isPassword: true,
                    prefixIcon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 20),

                  // Sign Up Button
                  AnimatedButton(
                    text: "Sign Up",
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      signUp();
                    },
                  ),
                  const SizedBox(height: 20),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already part of the family?",
                          style: TextStyle(color: Colors.white70)),
                      TextButton(
                        onPressed: toggles,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
