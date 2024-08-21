import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test_project/models/lesson_model.dart'; 
import 'package:test_project/services/lesson_service.dart';
import 'package:test_project/utils/lesson_card.dart';

class LessonsScreen extends StatefulWidget {
  final int courseId;

  const LessonsScreen({super.key, required this.courseId});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  late Future<List<Lessons>> _lessonsFuture;

  @override
  void initState() {
    super.initState();
    var token = Hive.box('auth').get('token');
    _lessonsFuture = LessonService(token).fetchLessons(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lessons'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Lessons>>(
        future: _lessonsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No lessons found.'));
          } else {
            List<Lessons> lessons = snapshot.data!;
            return ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return LessonCard(lesson: lessons[index]);
              },
            );
          }
        },
      ),
    );
  }
}
