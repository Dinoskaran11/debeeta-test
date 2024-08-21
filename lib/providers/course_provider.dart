
import 'package:flutter/material.dart';
import 'package:test_project/models/course_model.dart';
import 'package:test_project/services/course_service.dart';

class CourseProvider extends ChangeNotifier {
  List<Course> _courses = [];
  final CourseService courseService;

  CourseProvider(this.courseService);

  List<Course> get courses => _courses;

  void fetchCourses() async {
    try {
      _courses = await courseService.fetchCourses();
      notifyListeners();
    } catch (e) {
      throw Exception("faild to load");
    }
  }
}
