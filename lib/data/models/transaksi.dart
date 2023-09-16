import 'dart:convert';

import 'package:flutter_dompet/data/models/dompet.dart';
import 'package:flutter_dompet/data/models/user.dart';

class Transaksi {
  int? id;
  String? date;
  String? amount;
  String? cost;
  String? revenue;
  String? status;
  String? desc;
  User? user;
  Dompet? from;
  Dompet? to;

  Transaksi({
    this.id,
    this.date,
    this.amount,
    this.cost,
    this.revenue,
    this.status,
    this.desc,
    this.user,
    this.from,
    this.to,
  });

  factory Transaksi.fromJson(String str) => Transaksi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Transaksi.fromMap(Map<String, dynamic> json) => Transaksi(
        id: json["id"],
        date: json["date"],
        amount: json["amount"],
        cost: json["cost"],
        revenue: json["revenue"],
        status: json["status"],
        desc: json["desc"],
        user: User.fromMap(json["user"]),
        from: Dompet.fromMap(json["from"]),
        to: Dompet.fromMap(json["to"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "date": date,
        "amount": amount,
        "cost": cost,
        "revenue": revenue,
        "status": status,
        "desc": desc,
        "user": user?.toMap(),
        "from": from?.toMap(),
        "to": to?.toMap(),
      };
}
