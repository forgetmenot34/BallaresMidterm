import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../models/course.dart';

class EnrollmentState {
  final Student student;
  final Course? selectedCourse;

  const EnrollmentState({this.student = Student.empty, this.selectedCourse});

  EnrollmentState copyWith({Student? student, Course? selectedCourse}) {
    return EnrollmentState(
      student: student ?? this.student,
      selectedCourse: selectedCourse ?? this.selectedCourse,
    );
  }

  static const empty = EnrollmentState();
}

class EnrollmentNotifier extends StateNotifier<EnrollmentState> {
  EnrollmentNotifier() : super(EnrollmentState.empty);

  void setStudent(Student s) => state = state.copyWith(student: s);

  void selectCourse(Course c) => state = state.copyWith(selectedCourse: c);

  void clear() => state = EnrollmentState.empty;
}

final enrollmentProvider =
    StateNotifierProvider<EnrollmentNotifier, EnrollmentState>((ref) {
      return EnrollmentNotifier();
    });
