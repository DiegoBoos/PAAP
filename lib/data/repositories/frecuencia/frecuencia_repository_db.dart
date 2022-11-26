import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';
import '../../../domain/entities/frecuencia_entity.dart';
import '../../../domain/repositories/frecuencia/frecuencia_repository_db.dart';
import '../../datasources/local/frecuencia_local_ds.dart';

class FrecuenciaRepositoryDBImpl implements FrecuenciaRepositoryDB {
  final FrecuenciaLocalDataSource frecuenciaLocalDataSource;

  FrecuenciaRepositoryDBImpl({required this.frecuenciaLocalDataSource});

  @override
  Future<Either<Failure, List<FrecuenciaEntity>>>
      getFrecuenciasRepositoryDB() async {
    try {
      final frecuenciasDB = await frecuenciaLocalDataSource.getFrecuenciasDB();

      return Right(frecuenciasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveFrecuenciasRepositoryDB(
      List<FrecuenciaEntity> frecuenciaEntity) async {
    try {
      final frecuenciaDB =
          await frecuenciaLocalDataSource.saveFrecuencias(frecuenciaEntity);
      return Right(frecuenciaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
