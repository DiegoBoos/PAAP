import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/visita_entity.dart';
import '../../../domain/repositories/visita/visita_repository_db.dart';
import '../../datasources/local/visita_local_ds.dart';

class VisitaRepositoryDBImpl implements VisitaRepositoryDB {
  final VisitaLocalDataSource visitaLocalDataSource;

  VisitaRepositoryDBImpl({required this.visitaLocalDataSource});

  @override
  Future<Either<Failure, VisitaEntity?>> getVisitaRepositoryDB(
      String perfilId, String tipoVisitaId) async {
    try {
      final visitasDB =
          await visitaLocalDataSource.getVisita(perfilId, tipoVisitaId);

      return Right(visitasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, VisitaEntity>> saveVisitaEvaluacionRepositoryDB(
      VisitaEntity visitaEntity) async {
    try {
      final visitasDB =
          await visitaLocalDataSource.saveVisitaEvaluacion(visitaEntity);

      return Right(visitasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveVisitasRepositoryDB(
      List<VisitaEntity> visitasEntity) async {
    try {
      final result = await visitaLocalDataSource.saveVisitasDB(visitasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<VisitaEntity>>>
      getVisitasProduccionRepositoryDB() async {
    try {
      final visitasDB = await visitaLocalDataSource.getVisitasProduccionDB();

      return Right(visitasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> updateVisitasProduccionDBRepositoryDB(
      List<VisitaEntity> visitasEntity) async {
    try {
      final result =
          await visitaLocalDataSource.updateVisitasProduccionDB(visitasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> clearVisitasRepositoryDB() async {
    try {
      final result = await visitaLocalDataSource.clearVisitasDB();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
