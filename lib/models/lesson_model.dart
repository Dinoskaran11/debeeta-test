import 'dart:convert';

List<Lessons> lessonsFromJson(String str) => List<Lessons>.from(json.decode(str).map((x) => Lessons.fromJson(x)));

String lessonsToJson(List<Lessons> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Lessons {
    int id;
    int courseId;
    String title;
    String content;
    DateTime createdAt;
    DateTime updatedAt;

    Lessons({
        required this.id,
        required this.courseId,
        required this.title,
        required this.content,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Lessons.fromJson(Map<String, dynamic> json) => Lessons(
        id: json["id"],
        courseId: json["course_id"],
        title: json["title"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "title": title,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
