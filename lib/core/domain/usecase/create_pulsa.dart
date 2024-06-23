import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class CreatePulsa {
  final PulsaRepository repository;

  CreatePulsa(this.repository);

  Future<Either<Failure, String>> execute({required Pulsa? pulsa}) {
    return repository.createPulsa(pulsa: pulsa);
  }
}
