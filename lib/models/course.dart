class Course {
  final String id;
  final String name;
  final int credits;
  final String instructor;

  const Course({
    required this.id,
    required this.name,
    required this.credits,
    required this.instructor,
  });

  static const sampleCourses = [
    Course(
      id: 'CSE101',
      name: 'Intro to Programming',
      credits: 3,
      instructor: 'Dr. Navales',
    ),
    Course(
      id: 'MAT120',
      name: 'Calculus I',
      credits: 4,
      instructor: 'Prof. Ronde',
    ),
    Course(
      id: 'PHY101',
      name: 'Physics I',
      credits: 3,
      instructor: 'Dr. Romeo',
    ),
    Course(
      id: 'ENG201',
      name: 'Technical Writing',
      credits: 2,
      instructor: 'Ms. Hernando',
    ),
    Course(
      id: 'HIS110',
      name: 'World History',
      credits: 2,
      instructor: 'Mr. Espinosa',
    ),
  ];
}
