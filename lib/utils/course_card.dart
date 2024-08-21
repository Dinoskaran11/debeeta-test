import 'package:flutter/material.dart';
import 'package:test_project/models/course_model.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[500],
      margin: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 0.0),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, '/lessons',
          arguments: course.id
          );
        },

        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              course.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("ID: ${course.id}",
              style: TextStyle(
                fontSize: 16
              ),
            ),
            SizedBox(height: 8),
            Text("Description: ${course.description}"),
            
          ],
        ),
      ),
      ),
    );
  }
}