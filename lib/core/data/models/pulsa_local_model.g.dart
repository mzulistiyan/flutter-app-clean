// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pulsa_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PulsaLocalModelAdapter extends TypeAdapter<PulsaLocalModel> {
  @override
  final int typeId = 0;

  @override
  PulsaLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PulsaLocalModel(
      id: fields[0] as String?,
      bank: fields[1] as String?,
      nominal: fields[2] as int?,
      noRek: fields[3] as int?,
      atasNama: fields[4] as String?,
      uangDiterima: fields[5] as int?,
      nomorPengirim: fields[6] as int?,
      provider: fields[7] as String?,
      createdAt: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PulsaLocalModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bank)
      ..writeByte(2)
      ..write(obj.nominal)
      ..writeByte(3)
      ..write(obj.noRek)
      ..writeByte(4)
      ..write(obj.atasNama)
      ..writeByte(5)
      ..write(obj.uangDiterima)
      ..writeByte(6)
      ..write(obj.nomorPengirim)
      ..writeByte(7)
      ..write(obj.provider)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PulsaLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
