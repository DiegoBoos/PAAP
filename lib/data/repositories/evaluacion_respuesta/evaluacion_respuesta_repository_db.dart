import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/evaluacion_respuesta_entity.dart';
import '../../../domain/repositories/evaluacion_respuesta/evaluacion_respuesta_repository_db.dart';
import '../../datasources/local/evaluacion_respuesta/evaluacion_respuesta_local_ds.dart';

class EvaluacionRespuestaRepositoryDBImpl
    implements EvaluacionRespuestaRepositoryDB {
  final EvaluacionRespuestaLocalDataSource evaluacionRespuestaLocalDataSource;

  EvaluacionRespuestaRepositoryDBImpl(
      {required this.evaluacionRespuestaLocalDataSource});

  @override
  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasProduccionRepositoryDB() async {
    try {
      final evaluacionesRespuestasDB = await evaluacionRespuestaLocalDataSource
          .getEvaluacionesRespuestasProduccionDB();

      return Right(evaluacionesRespuestasDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, EvaluacionRespuestaEntity?>>
      getEvaluacionRespuestaRepositoryDB(
          String criterioId, String evaluacionId) async {
    try {
      final result = await evaluacionRespuestaLocalDataSource
          .getEvaluacionRespuestaDB(criterioId, evaluacionId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEvaluacionRespuestaRepositoryDB(
      EvaluacionRespuestaEntity evaluacionRespuestaEntity,
      String perfilId) async {
    try {
      final result = await evaluacionRespuestaLocalDataSource
          .saveEvaluacionRespuestaDB(evaluacionRespuestaEntity, perfilId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEvaluacionesRespuestasRepositoryDB(
      List<EvaluacionRespuestaEntity> evaluacionEntity) async {
    try {
      final evaluacionRespuestaDB = await evaluacionRespuestaLocalDataSource
          .saveEvaluacionesRespuestasDB(evaluacionEntity);
      return Right(evaluacionRespuestaDB);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>>
      updateEvaluacionesRespuestasProduccionDBRepositoryDB(
          List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity) async {
    try {
      final result = await evaluacionRespuestaLocalDataSource
          .updateEvaluacionesRespuestasProduccionDB(
              evaluacionesRespuestasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> clearEvaluacionesRespuestasRepositoryDB() async {
    try {
      final result = await evaluacionRespuestaLocalDataSource
          .clearEvaluacionesRespuestasDB();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
