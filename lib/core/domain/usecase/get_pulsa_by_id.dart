import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class GetPulsaById {
  final PulsaRepository repository;

  GetPulsaById(this.repository);

  Future<Either<Failure, Pulsa>> execute({String? id}) {
    return repository.getPulsaById(id: id);
  }
}
