import 'package:flutter/material.dart';
import 'package:test_project/models/lesson_model.dart';


class LessonCard extends StatelessWidget {
  final Lessons lesson;

  const LessonCard({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[500],
      margin: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              lesson.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("ID: ${lesson.id}",
              style: TextStyle(
                fontSize: 16
              ),
            ),
            SizedBox(height: 8),
            Text("Content: ${lesson.content}"),
           
          ],
        ),
      ),
    );
  }
}