// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:socialmedia_app/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:socialmedia_app/widgets/custom_button.dart';
// import 'package:socialmedia_app/widgets/custom_textfield.dart';

// class LoginPage extends StatefulWidget {
//   final void Function()? toggles;
//   LoginPage({
//     super.key,
//     required this.toggles,
//   });

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// final TextEditingController emailController = TextEditingController();
// final TextEditingController passwordController = TextEditingController();

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     void login() {
//       final String email = emailController.text.trim();
//       final String password = passwordController.text.trim();

//       //auth cubit
//       final AuthCubit authCubit = context.read<AuthCubit>();

//       if (email.isNotEmpty && password.isNotEmpty) {
//         //lets login the user
//         authCubit.loginUser(email, password);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Please Enter check both the fields',
//             ),
//           ),
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
//             child: Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Welcome Message
//                   const Text(
//                     "Welcome Back!",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   const Text(
//                     "Let's get you logged in!",
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 30),

//                   // Email Field
//                   CustomTextField(
//                     hintText: "Email",
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     prefixIcon: Icons.email_outlined,
//                   ),
//                   const SizedBox(height: 15),

//                   // Password Field
//                   CustomTextField(
//                     hintText: "Password",
//                     controller: passwordController,
//                     isPassword: true,
//                     prefixIcon: Icons.lock_outline,
//                   ),
//                   const SizedBox(height: 10),

//                   // Forgot Password
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {},
//                       child: const Text(
//                         "Forgot Password?",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Login Button
//                   AnimatedButton(
//                     text: "Login",
//                     onPressed: () {
//                       FocusScope.of(context).unfocus();
//                       // Login logic
//                       login();
//                     },
//                   ),

//                   const SizedBox(height: 20),

//                   // Sign Up Link
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have an account?",
//                           style: TextStyle(color: Colors.black)),
//                       TextButton(
//                         onPressed: widget.toggles,
//                         child: const Text(
//                           "Sign Up",
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

class LoginPage extends StatefulWidget {
  final void Function()? toggles;
  LoginPage({super.key, required this.toggles});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    final AuthCubit authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.loginUser(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please check both fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void loginAsTestUser() {
    setState(() {
      emailController.text = "test@gmail.com";
      passwordController.text = "Test@123";
    });
    login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Message
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Let's get you logged in!",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  CustomTextField(
                    hintText: "Email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 15),

                  // Password Field
                  CustomTextField(
                    hintText: "Password",
                    controller: passwordController,
                    isPassword: true,
                    prefixIcon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 10),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.greenAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  AnimatedButton(
                    text: "Login",
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      login();
                    },
                  ),

                  const SizedBox(height: 10),

                  // Login as Test User Button
                  AnimatedButton(
                    text: "Login as Test User",
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      loginAsTestUser();
                    },
                    color: Colors.blueGrey,
                  ),

                  const SizedBox(height: 20),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(color: Colors.white70)),
                      TextButton(
                        onPressed: widget.toggles,
                        child: const Text(
                          "Sign Up",
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
