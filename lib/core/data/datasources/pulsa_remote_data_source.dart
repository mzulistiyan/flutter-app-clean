import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../core.dart';

abstract class PulsaRemoteDataSource {
  Future<List<Pulsa>> getPulsa({String? search});
  Future<Pulsa> getPulsaById({required String? id});
  Future<String> createPulsa({required Pulsa? pulsa});
  Future<String> updatePulsa({required Pulsa? pulsa, required String? id});
  Future<String> deletePulsa({required String? id});
}

class PulsaRemoteDataSourceImpl implements PulsaRemoteDataSource {
  final DioClient dioClient;

  PulsaRemoteDataSourceImpl({
    required this.dioClient,
  });

  @override
  Future<List<Pulsa>> getPulsa({String? search}) async {
    String url = search != null ? '${UrlConstant.pulsa}?nomor_pengirim=$search' : UrlConstant.pulsa;

    final response = await dioClient.get(
      url: url,
    );

    if (response.statusCode == 200) {
      return List<Pulsa>.from(response.data.map((x) => Pulsa.fromJson(x)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Pulsa> getPulsaById({required String? id}) async {
    final response = await dioClient.get(
      url: '${UrlConstant.pulsa}/$id',
    );

    if (response.statusCode == 200) {
      return Pulsa.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createPulsa({required Pulsa? pulsa}) async {
    Map<String, dynamic> data = pulsa!.toJson();
    data.remove('createdAt');
    data.remove('id');

    final response = await dioClient.post(
      url: UrlConstant.pulsa,
      data: data,
    );

    if (response.statusCode == 201) {
      return 'Success';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> updatePulsa({required Pulsa? pulsa, required String? id}) async {
    Map<String, dynamic> data = pulsa!.toJson();
    data.remove('createdAt');
    data.remove('id');
    data.remove('provider');
    data.remove('uang_diterima');
    debugPrint('data Pulsa: $data');

    final response = await dioClient.put(
      url: '${UrlConstant.pulsa}/$id',
      data: data,
    );

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deletePulsa({required String? id}) async {
    final response = await dioClient.delete(
      url: '${UrlConstant.pulsa}/$id',
    );

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      throw ServerException();
    }
  }
}
