import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/evaluacion_entity.dart';
import '../../../domain/repositories/evaluacion/evaluacion_repository_db.dart';
import '../../datasources/local/evaluacion/evaluacion_local_ds.dart';

class EvaluacionRepositoryDBImpl implements EvaluacionRepositoryDB {
  final EvaluacionLocalDataSource evaluacionLocalDataSource;

  EvaluacionRepositoryDBImpl({required this.evaluacionLocalDataSource});

  @override
  Future<Either<Failure, List<EvaluacionEntity>>>
      getEvaluacionesProduccionRepositoryDB() async {
    try {
      final evaluacionesDB =
          await evaluacionLocalDataSource.getEvaluacionesProduccionDB();

      return Right(evaluacionesDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, EvaluacionEntity?>> getEvaluacionRepositoryDB(
      String perfilId) async {
    try {
      final result = await evaluacionLocalDataSource.getEvaluacionDB(perfilId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEvaluacionRepositoryDB(
      EvaluacionEntity evaluacionEntity) async {
    try {
      final result =
          await evaluacionLocalDataSource.saveEvaluacionDB(evaluacionEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEvaluacionesRepositoryDB(
      List<EvaluacionEntity> evaluacionEntity) async {
    try {
      final evaluacionDB =
          await evaluacionLocalDataSource.saveEvaluacionesDB(evaluacionEntity);
      return Right(evaluacionDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> updateEvaluacionesProduccionDBRepositoryDB(
      List<EvaluacionEntity> evaluacionesEntity) async {
    try {
      final result = await evaluacionLocalDataSource
          .updateEvaluacionesProduccionDB(evaluacionesEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> clearEvaluacionesRepositoryDB() async {
    try {
      final result = await evaluacionLocalDataSource.clearEvaluacionesDB();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
