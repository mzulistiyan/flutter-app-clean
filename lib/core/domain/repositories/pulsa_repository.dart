import 'package:dartz/dartz.dart';
import '../../../common/common.dart';
import '../../core.dart';

abstract class PulsaRepository {
  Future<Either<Failure, List<Pulsa>>> getPulsa({String? search});
  Future<Either<Failure, Pulsa>> getPulsaById({required String? id});
  Future<Either<Failure, String>> createPulsa({required Pulsa? pulsa});
  Future<Either<Failure, String>> updatePulsa({required Pulsa? pulsa, required String? id});
  Future<Either<Failure, String>> deletePulsa({required String? id});

  //Local Data Source
  Future<Either<Failure, List<Pulsa>>> getLocalPulsa();
  Future<Either<Failure, String>> insertLocalPulsa({required List<Pulsa>? pulsa});
}
