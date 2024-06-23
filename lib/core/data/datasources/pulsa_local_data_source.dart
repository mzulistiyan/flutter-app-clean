import 'package:hive/hive.dart';

import '../../core.dart';

abstract class PulsaLocalDataSource {
  Future<List<Pulsa>> getLocalPulsa();
  Future<String> insertLocalPulsa({required List<Pulsa>? pulsa});
}

class PulsaLocalDataSourceImpl implements PulsaLocalDataSource {
  PulsaLocalDataSourceImpl();

  @override
  Future<List<Pulsa>> getLocalPulsa() async {
    final box = await Hive.openBox<PulsaLocalModel>('pulsa');
    List<PulsaLocalModel> pulsaLocalModel = box.values.toList();
    List<Pulsa> pulsa = pulsaLocalModel.map((e) => e.toEntity()).toList();
    return pulsa;
  }

  @override
  Future<String> insertLocalPulsa({required List<Pulsa>? pulsa}) async {
    final box = await Hive.openBox<PulsaLocalModel>('pulsa');
    box.clear();
    List<PulsaLocalModel> pulsaLocalModel = pulsa!
        .map((e) => PulsaLocalModel(
              id: e.id,
              bank: e.bank,
              nominal: e.nominal,
              noRek: e.noRek,
              atasNama: e.atasNama,
              uangDiterima: e.uangDiterima,
              nomorPengirim: e.nomorPengirim,
              provider: e.provider,
              createdAt: e.createdAt,
            ))
        .toList();
    box.addAll(pulsaLocalModel);
    return 'Success';
  }
}
