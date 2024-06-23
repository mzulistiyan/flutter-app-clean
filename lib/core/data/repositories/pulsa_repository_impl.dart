import '../../../common/common.dart';
import '../../core.dart';
import 'package:dartz/dartz.dart';

class PulsaRepositoryImpl implements PulsaRepository {
  final PulsaRemoteDataSource remoteDataSource;
  final PulsaLocalDataSource localDataSource;

  PulsaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> createPulsa({required Pulsa? pulsa}) async {
    try {
      final result = await remoteDataSource.createPulsa(pulsa: pulsa);
      return Right(result);
    } on ServerException {
      return const Left(const ServerFailure('Gagal membuat data pulsa'));
    }
  }

  @override
  Future<Either<Failure, String>> deletePulsa({required String? id}) async {
    try {
      final result = await remoteDataSource.deletePulsa(id: id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure('Gagal menghapus data pulsa dengan id: $id'));
    }
  }

  @override
  Future<Either<Failure, List<Pulsa>>> getPulsa({String? search}) async {
    try {
      final result = await remoteDataSource.getPulsa(search: search);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Gagal mendapatkan data pulsa'));
    }
  }

  @override
  Future<Either<Failure, Pulsa>> getPulsaById({required String? id}) async {
    try {
      final result = await remoteDataSource.getPulsaById(id: id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure('Gagal mendapatkan data pulsa dengan id: $id'));
    }
  }

  @override
  Future<Either<Failure, String>> updatePulsa({required Pulsa? pulsa, required String? id}) async {
    try {
      final result = await remoteDataSource.updatePulsa(pulsa: pulsa, id: id);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure('Gagal mengupdate data pulsa dengan id: $id'));
    }
  }

  @override
  Future<Either<Failure, List<Pulsa>>> getLocalPulsa() async {
    try {
      final result = await localDataSource.getLocalPulsa();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Gagal mendapatkan data pulsa'));
    }
  }

  @override
  Future<Either<Failure, String>> insertLocalPulsa({required List<Pulsa>? pulsa}) async {
    try {
      final result = await localDataSource.insertLocalPulsa(pulsa: pulsa);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('Gagal membuat data pulsa'));
    }
  }
}
