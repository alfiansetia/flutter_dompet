import 'dart:convert';

import 'package:flutter_dompet/data/models/user.dart';

class AuthResponseModel {
  AuthResponseModel({
    required this.jwtToken,
    required this.user,
  });

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        jwtToken: json["token"],
        user: User.fromMap(json["user"]),
      );

  final String jwtToken;
  final User user;

  factory AuthResponseModel.initial() => AuthResponseModel(
        jwtToken: '',
        user: User(
            id: 1,
            name: 'name',
            phone: 'phone',
            avatar: 'avatar',
            role: 'user',
            status: 'status'),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "token": jwtToken,
        "user": user.toMap(),
      };
}
