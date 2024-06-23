import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class UpdatePulsa {
  final PulsaRepository repository;

  UpdatePulsa(this.repository);

  Future<Either<Failure, String>> execute({required Pulsa? pulsa, required String? id}) {
    return repository.updatePulsa(pulsa: pulsa, id: id);
  }
}
