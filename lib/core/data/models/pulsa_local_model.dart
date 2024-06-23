import 'package:flutter_application_clean_arch/core/core.dart';
import 'package:hive/hive.dart';

part 'pulsa_local_model.g.dart';

@HiveType(typeId: 0)
class PulsaLocalModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? bank;

  @HiveField(2)
  int? nominal;

  @HiveField(3)
  int? noRek;

  @HiveField(4)
  String? atasNama;

  @HiveField(5)
  int? uangDiterima;

  @HiveField(6)
  int? nomorPengirim;

  @HiveField(7)
  String? provider;

  @HiveField(8)
  DateTime? createdAt;

  PulsaLocalModel({
    this.id,
    this.bank,
    this.nominal,
    this.noRek,
    this.atasNama,
    this.uangDiterima,
    this.nomorPengirim,
    this.provider,
    this.createdAt,
  });

  Pulsa toEntity() {
    return Pulsa(
      id: id,
      bank: bank,
      nominal: nominal,
      noRek: noRek,
      atasNama: atasNama,
      uangDiterima: uangDiterima,
      nomorPengirim: nomorPengirim,
      provider: provider,
      createdAt: createdAt,
    );
  }
}
