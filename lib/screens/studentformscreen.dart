// studentformscreen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/student.dart';
import '/providers/enrolment_provider.dart';
import 'courseselectionscreen.dart';

// (Existing State and methods remain the same)

class StudentFormScreen extends ConsumerStatefulWidget {
  static const routeName = '/';
  const StudentFormScreen({super.key});

  @override
  ConsumerState<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends ConsumerState<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _studentID = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _studentID.dispose();
    super.dispose();
  }

  void _next() {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        firstName: _firstName.text.trim(),
        lastName: _lastName.text.trim(),
        email: _email.text.trim(),
        studentID: _studentID.text.trim(),
      );
      ref.read(enrollmentProvider.notifier).setStudent(student);
      Navigator.pushNamed(context, CourseSelectionScreen.routeName);
    }
  }

  String? _validateNotEmpty(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;
  String? _validateEmail(String? v) =>
      (v == null || !v.contains('@')) ? 'Invalid email' : null;

  @override
  Widget build(BuildContext context) {
    // Get the custom green color from the theme
    final primaryColor = Theme.of(context).primaryColor;
    
    return Scaffold(
      // Custom AppBar for the title styling
      appBar: AppBar(
        title: Text(
          'Student Information',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24), // Increased padding
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Header/Prompt Text
              Text(
                'Enter Your Information',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Please fill in all the required fields to continue with course enrollment.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Form Fields with Icons and Border
              _buildTextFormField(
                controller: _firstName,
                label: 'First Name',
                icon: Icons.person_outline,
                validator: _validateNotEmpty,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _lastName,
                label: 'Last Name',
                icon: Icons.person_outline,
                validator: _validateNotEmpty,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _email,
                label: 'Email',
                icon: Icons.mail_outline,
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _studentID,
                label: 'Student ID',
                icon: Icons.credit_card_outlined,
                validator: _validateNotEmpty,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 40),
              // Elevated button uses the style defined in main.dart
              ElevatedButton(
                onPressed: _next,
                child: const Text('Continue to Course Selection'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for consistent TextFormField styling
  TextFormField _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      ),
      validator: validator,
    );
  }
}