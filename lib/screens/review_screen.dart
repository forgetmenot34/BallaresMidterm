// review_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/enrolment_provider.dart';
import 'studentformscreen.dart';

class ReviewScreen extends ConsumerWidget {
  static const routeName = '/review';
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(enrollmentProvider);
    final student = state.student;
    final course = state.selectedCourse;
    final primaryColor = Theme.of(context).primaryColor;

    Future<void> _showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 30),
              const SizedBox(width: 10),
              const Text('Success!'),
            ],
          ),
          content: const Text(
            'Enrollment Successful!\nYou have been successfully enrolled in the course.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Enrollment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: (course == null)
            ? const Center(child: Text('No course selected.', style: TextStyle(fontSize: 16, color: Colors.grey)))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Please Review Your Enrollment',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Verify all information is correct before confirming.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // --- Student Information Card ---
                  _buildReviewCard(
                    context,
                    title: 'Student Information',
                    icon: Icons.person_outline,
                    details: {
                      'First Name': student.firstName,
                      'Last Name': student.lastName,
                      'Email': student.email,
                      'Student ID': student.studentID,
                    },
                  ),
                  const SizedBox(height: 16),

                  // --- Selected Course Card ---
                  _buildReviewCard(
                    context,
                    title: 'Selected Course',
                    icon: Icons.school_outlined,
                    details: {
                      'Course Name': course.name,
                      'Course ID': course.id,
                      'Instructor': course.instructor,
                      'Credits': course.credits.toString(),
                    },
                  ),
                  const Spacer(),
                  
                  // --- Buttons ---
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _showSuccessDialog();
                      // Clear state and navigate back to the start
                      ref.read(enrollmentProvider.notifier).clear();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        StudentFormScreen.routeName,
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Confirm Enrollment'),
                    style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      // Ensure green is used for the checkmark button
                      backgroundColor: MaterialStateProperty.all(primaryColor), 
                    )
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to Course Selection
                    },
                    child: const Text('Go Back'),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryColor, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      foregroundColor: primaryColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// Helper method to build the review Card
Widget _buildReviewCard(BuildContext context, {
  required String title,
  required IconData icon,
  required Map<String, String> details,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
            ],
          ),
          const Divider(height: 20),
          ...details.entries.map((entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100, // Fixed width for labels
                      child: Text(
                        '${entry.key}:',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(entry.value),
                    ),
                  ],
                ),
              )).toList(),
        ],
      ),
    ),
  );
}