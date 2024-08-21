import 'package:flutter/material.dart';
import 'package:test_project/models/course_model.dart';
import 'package:test_project/services/course_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_project/utils/course_card.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  void _fetchCourses() {
    var token = Hive.box('auth').get('token');
    CourseService courseService = CourseService(token);
    _coursesFuture = courseService.fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Course>>(
        future: _coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No courses available'));
          } else {
            
            List<Course> courses = snapshot.data!;
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return CourseCard(course: courses[index]);
              },
            );
          }
        },
      ),
    );
  }
}
