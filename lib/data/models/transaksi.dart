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
    this.number,
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
        number: json["number"],
      );

  factory Transaksi.initial() => Transaksi(
      id: 1,
      date: '',
      amount: 0,
      cost: 0,
      desc: '',
      revenue: 0,
      status: '',
      from: Dompet.initial(),
      to: Dompet.initial(),
      user: User.initial(),
      number: '');

  int? amount;
  int? cost;
  String? date;
  String? desc;
  Dompet? from;
  int? id;
  int? revenue;
  String? status;
  Dompet? to;
  User? user;
  String? number;

  String toJson() => json.encode(toMap());

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
        "number": number,
      };
}
