import 'dart:convert';

class Dompet {
  int? id;
  String? name;
  String? type;
  String? accName;
  String? accNumber;
  String? saldo;

  Dompet({
    this.id,
    this.name,
    this.type,
    this.accName,
    this.accNumber,
    this.saldo,
  });

  factory Dompet.fromJson(String str) => Dompet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Dompet.fromMap(Map<String, dynamic> json) => Dompet(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        accName: json["acc_name"],
        accNumber: json["acc_number"],
        saldo: json["saldo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "acc_name": accName,
        "acc_number": accNumber,
        "saldo": saldo,
      };
}
