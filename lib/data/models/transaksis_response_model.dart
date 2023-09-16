import 'dart:convert';

import 'package:flutter_dompet/data/models/links.dart';
import 'package:flutter_dompet/data/models/meta.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';

class TransaksisResponseModel {
  List<Transaksi>? data;
  Links? links;
  Meta? meta;

  TransaksisResponseModel({
    this.data,
    this.links,
    this.meta,
  });

  factory TransaksisResponseModel.fromJson(String str) =>
      TransaksisResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransaksisResponseModel.fromMap(Map<String, dynamic> json) =>
      TransaksisResponseModel(
        data: json["data"] == null
            ? []
            : List<Transaksi>.from(
                json["data"]!.map((x) => Transaksi.fromMap(x))),
        links: json["links"] == null ? null : Links.fromMap(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "links": links?.toMap(),
        "meta": meta?.toMap(),
      };
}
