import 'dart:convert';

import 'package:flutter_dompet/data/models/dompet.dart';
import 'package:flutter_dompet/data/models/links.dart';
import 'package:flutter_dompet/data/models/meta.dart';

class DompetsResponseModel {
  DompetsResponseModel({
    this.data,
    this.links,
    this.meta,
  });

  factory DompetsResponseModel.fromJson(String str) =>
      DompetsResponseModel.fromMap(json.decode(str));

  factory DompetsResponseModel.fromMap(Map<String, dynamic> json) =>
      DompetsResponseModel(
        data: json["data"] == null
            ? []
            : List<Dompet>.from(json["data"]!.map((x) => Dompet.fromMap(x))),
        links: json["links"] == null ? null : Links.fromMap(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
      );

  List<Dompet>? data;
  Links? links;
  Meta? meta;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "links": links?.toMap(),
        "meta": meta?.toMap(),
      };
}
