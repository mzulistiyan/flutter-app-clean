import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class GetLocalList {
  final PulsaRepository repository;

  GetLocalList(this.repository);

  Future<Either<Failure, List<Pulsa>>> execute() {
    return repository.getLocalPulsa();
  }
}
