import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class DeletePulsa {
  final PulsaRepository repository;

  DeletePulsa(this.repository);

  Future<Either<Failure, String>> execute({required String? id}) {
    return repository.deletePulsa(id: id);
  }
}
