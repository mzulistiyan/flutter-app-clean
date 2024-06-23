import 'package:dartz/dartz.dart';

import '../../core.dart';
import '../../../common/common.dart';

class GetListPulsa {
  final PulsaRepository repository;

  GetListPulsa(this.repository);

  Future<Either<Failure, List<Pulsa>>> execute({String? search}) {
    return repository.getPulsa(search: search);
  }
}
