import 'dart:convert';

class User {
  final int? id;
  final String? name;
  final String? phone;
  final String? avatar;
  final String? role;
  final String? status;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.avatar,
    required this.role,
    required this.status,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        avatar: json["avatar"],
        role: json["role"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone": phone,
        "avatar": avatar,
        "role": role,
        "status": status,
      };
}
