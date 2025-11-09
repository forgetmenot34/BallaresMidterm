class Student {
  final String firstName;
  final String lastName;
  final String email;
  final String studentID;

  const Student({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.studentID,
  });

  static const empty = Student(
    firstName: '',
    lastName: '',
    email: '',
    studentID: '',
  );

  bool get isEmpty =>
      firstName.isEmpty &&
      lastName.isEmpty &&
      email.isEmpty &&
      studentID.isEmpty;
}
