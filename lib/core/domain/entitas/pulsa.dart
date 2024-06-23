// To parse this JSON data, do
//
//     final pulsa = pulsaFromJson(jsonString);

import 'dart:convert';

List<Pulsa> pulsaFromJson(String str) => List<Pulsa>.from(json.decode(str).map((x) => Pulsa.fromJson(x)));

String pulsaToJson(List<Pulsa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pulsa {
  DateTime? createdAt;
  int? nominal;
  String? bank;
  int? noRek;
  String? atasNama;
  int? uangDiterima;
  int? nomorPengirim;
  String? provider;
  String? id;

  Pulsa({
    this.createdAt,
    this.nominal,
    this.bank,
    this.noRek,
    this.atasNama,
    this.uangDiterima,
    this.nomorPengirim,
    this.provider,
    this.id,
  });

  factory Pulsa.fromJson(Map<String, dynamic> json) => Pulsa(
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        nominal: json["nominal"],
        bank: json["bank"],
        noRek: json["no_rek"],
        atasNama: json["atas_nama"],
        uangDiterima: json["uang_diterima"],
        nomorPengirim: json["nomor_pengirim"],
        provider: json["provider"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "nominal": nominal,
        "bank": bank,
        "no_rek": noRek,
        "atas_nama": atasNama,
        "uang_diterima": uangDiterima,
        "nomor_pengirim": nomorPengirim,
        "provider": provider,
        "id": id,
      };
}
