import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:test_project/models/course_model.dart';

class CourseService {
  final String baseUrl = "https://festive-clarke.93-51-37-244.plesk.page/api/v1";
  final String? token;

  CourseService(this.token);

  Future<List<Course>> fetchCourses() async {


    final response = await http.get(
      Uri.parse('$baseUrl/courses'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }


  Future<Course?> fetchCourseById(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/courses/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Course.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load course');
    }
  }

 
}
