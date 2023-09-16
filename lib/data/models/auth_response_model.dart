import 'dart:convert';

import 'package:flutter_dompet/data/models/user.dart';

class AuthResponseModel {
  final String jwtToken;
  final User user;

  AuthResponseModel({
    required this.jwtToken,
    required this.user,
  });

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        jwtToken: json["token"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "token": jwtToken,
        "user": user.toMap(),
      };
}
