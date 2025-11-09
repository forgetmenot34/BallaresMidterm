// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/studentformscreen.dart';
import 'screens/courseselectionscreen.dart';
import 'screens/review_screen.dart';

// Define the custom primary color (Dark Green)
const Color primaryGreen = Color.fromARGB(255, 29, 22, 159);

void main() {
  runApp(const ProviderScope(child: MidtermEnrollmentApp()));
}

class MidtermEnrollmentApp extends StatelessWidget {
  const MidtermEnrollmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Midterm: Course Enrollment',
      theme: ThemeData(
        // Use the custom color for the primary swatch
        primarySwatch: createMaterialColor(primaryGreen),
        // Set the primary color specifically for AppBar and buttons
        primaryColor: primaryGreen,
        useMaterial3: true,
        // Define styles for elevated buttons for consistency
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen, // Dark green button background
            foregroundColor: Colors.white, // White text
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        // Define styles for outlined/text buttons (like 'Go Back')
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primaryGreen),
        ),
        // FIX: Changed CardTheme to CardThemeData
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      initialRoute: StudentFormScreen.routeName,
      routes: {
        StudentFormScreen.routeName: (_) => const StudentFormScreen(),
        CourseSelectionScreen.routeName: (_) => const CourseSelectionScreen(),
        ReviewScreen.routeName: (_) => const ReviewScreen(),
      },
    );
  }
}

// Helper function to create a MaterialColor from a single Color
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
