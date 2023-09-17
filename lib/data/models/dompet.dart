import 'dart:convert';

class Dompet {
  Dompet({
    this.id,
    this.name,
    this.type,
    this.accName,
    this.accNumber,
    this.saldo,
  });

  factory Dompet.fromJson(String str) => Dompet.fromMap(json.decode(str));

  factory Dompet.fromMap(Map<String, dynamic> json) => Dompet(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        accName: json["acc_name"],
        accNumber: json["acc_number"],
        saldo: json["saldo"],
      );

  factory Dompet.initial() => Dompet(
        id: 1,
        name: '',
        saldo: '',
        type: '',
        accName: '',
        accNumber: '',
      );

  String? accName;
  String? accNumber;
  int? id;
  String? name;
  String? saldo;
  String? type;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "acc_name": accName,
        "acc_number": accNumber,
        "saldo": saldo,
      };
}
