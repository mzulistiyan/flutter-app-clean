import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class InsertLocalList {
  final PulsaRepository repository;

  InsertLocalList(this.repository);

  Future<Either<Failure, String>> execute({required List<Pulsa>? pulsa}) {
    return repository.insertLocalPulsa(pulsa: pulsa);
  }
}
