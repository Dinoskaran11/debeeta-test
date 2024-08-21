
import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
    String status;
    String message;
    User user;
    String token;

    Register({
        required this.status,
        required this.message,
        required this.user,
        required this.token,
    });

    factory Register.fromJson(Map<String, dynamic> json) => Register(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    String name;
    String email;
    String role;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    User({
        required this.name,
        required this.email,
        required this.role,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        role: json["role"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "role": role,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
