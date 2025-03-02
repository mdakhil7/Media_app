// import 'package:flutter/material.dart';

// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.grey[900], // Dark grey primary color
//     scaffoldBackgroundColor: Colors.white, // Background color
//     fontFamily: 'Poppins', // Apply Poppins globally

//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.white,
//       foregroundColor: Colors.black, // AppBar text/icon color
//       elevation: 0, // Flat design
//     ),

//     textTheme: const TextTheme(
//       headlineLarge: TextStyle(
//           fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
//       headlineMedium: TextStyle(
//           fontSize: 26, fontWeight: FontWeight.w600, color: Colors.black),
//       bodyLarge: TextStyle(
//           fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
//       bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
//       bodySmall: TextStyle(fontSize: 14, color: Colors.black54),
//       titleLarge: TextStyle(
//           fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
//     ),

//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.grey[900], // Dark grey button
//         foregroundColor: Colors.white, // White text
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     ),

//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.grey[200], // Light grey input background
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(color: Colors.grey),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: const BorderSide(color: Colors.grey, width: 2),
//       ),
//     ),

//     iconTheme: const IconThemeData(
//       color: Colors.black, // Default icon color
//     ),

//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: Colors.white,
//       selectedItemColor: Colors.grey[900], // Active tab color
//       unselectedItemColor: Colors.grey, // Inactive tab color
//     ),
//   );
// }

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkThemes = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black, // Black primary color
    scaffoldBackgroundColor: Colors.grey[900], // Dark grey background
    fontFamily: 'Poppins',

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white, // AppBar text/icon color
      elevation: 0,
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: TextStyle(
          fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white70),
      bodyLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.white60),
      bodySmall: TextStyle(fontSize: 14, color: Colors.white54),
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[850], // Dark grey input background
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.green),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.green, width: 2),
      ),
    ),

    iconTheme: const IconThemeData(
      color: Colors.green, // Default icon color
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.green, // Active tab color
      unselectedItemColor: Colors.grey, // Inactive tab color
    ),

    cardTheme: CardTheme(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
