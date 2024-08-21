import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_project/models/lesson_model.dart'; 

class LessonService {
  final String baseUrl = "https://festive-clarke.93-51-37-244.plesk.page/api/v1";
  final String? token;

  LessonService(this.token);

  Future<List<Lessons>> fetchLessons(int courseId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/courses/$courseId/lessons'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((lesson) => Lessons.fromJson(lesson)).toList();
    } else {
      throw Exception('Failed to load lessons');
    }
  }
}
