import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';

import '../../../domain/entities/evaluacion_entity.dart';
import '../../../domain/entities/evaluacion_respuesta_entity.dart';
import '../../../domain/repositories/evaluacion_respuesta/evaluacion_respuesta_repository_db.dart';
import '../../datasources/local/evaluacion_respuesta_local_ds.dart';

class EvaluacionRespuestaRepositoryDBImpl
    implements EvaluacionRespuestaRepositoryDB {
  final EvaluacionRespuestaLocalDataSource evaluacionRespuestaLocalDataSource;

  EvaluacionRespuestaRepositoryDBImpl(
      {required this.evaluacionRespuestaLocalDataSource});

  @override
  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasRepositoryDB(
          String criterioId, String evaluacionId) async {
    try {
      final evaluacionesRespuestas = await evaluacionRespuestaLocalDataSource
          .getEvaluacionesRespuestas(criterioId, evaluacionId);

      return Right(evaluacionesRespuestas);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, EvaluacionRespuestaEntity>>
      getEvaluacionRespuestaOpcionRepositoryDB(
          String criterioId, String evaluacionId, String opcionId) async {
    try {
      final evaluacionRespuesta = await evaluacionRespuestaLocalDataSource
          .getEvaluacionRespuestaOpcion(criterioId, evaluacionId, opcionId);

      return Right(evaluacionRespuesta);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasProduccionRepositoryDB() async {
    try {
      final evaluacionesRespuestas = await evaluacionRespuestaLocalDataSource
          .getEvaluacionesRespuestasProduccion();

      return Right(evaluacionesRespuestas);
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
      final evaluacionRespuesta = await evaluacionRespuestaLocalDataSource
          .getEvaluacionRespuesta(criterioId, evaluacionId);

      return Right(evaluacionRespuesta);
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
          .saveEvaluacionRespuesta(evaluacionRespuestaEntity, perfilId);

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
      final result = await evaluacionRespuestaLocalDataSource
          .saveEvaluacionesRespuestas(evaluacionEntity);
      return Right(result);
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
          .updateEvaluacionesRespuestasProduccion(evaluacionesRespuestasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> updateRespuestaRemoteEvaluacionIdRepositoryDB(
      List<EvaluacionEntity> evaluacionesEntity) async {
    try {
      final result = await evaluacionRespuestaLocalDataSource
          .updateRespuestaRemoteEvaluacionId(evaluacionesEntity);

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
          .clearEvaluacionesRespuestas();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
