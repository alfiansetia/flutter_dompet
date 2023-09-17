import 'dart:convert';

import 'package:flutter_dompet/data/models/dompet.dart';
import 'package:flutter_dompet/data/models/user.dart';

class Transaksi {
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

  String? amount;
  String? cost;
  String? date;
  String? desc;
  Dompet? from;
  int? id;
  String? revenue;
  String? status;
  Dompet? to;
  User? user;

  String toJson() => json.encode(toMap());

  factory Transaksi.initial() => Transaksi(
        id: 1,
        date: '',
        amount: '',
        cost: '',
        desc: '',
        revenue: '',
        status: '',
        from: Dompet.initial(),
        to: Dompet.initial(),
        user: User.initial(),
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
