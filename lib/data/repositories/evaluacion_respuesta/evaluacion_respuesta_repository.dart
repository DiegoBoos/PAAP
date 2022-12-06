import 'package:dartz/dartz.dart';

import '../../../domain/core/error/exception.dart';
import '../../../domain/core/error/failure.dart';

import '../../../domain/entities/evaluacion_entity.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/entities/evaluacion_respuesta_entity.dart';
import '../../../domain/repositories/evaluacion_respuesta/evaluacion_respuesta_repository.dart';
import '../../datasources/remote/evaluacion_respuesta_remote_ds.dart';

class EvaluacionRespuestaRepositoryImpl
    implements EvaluacionRespuestaRepository {
  final EvaluacionRespuestaRemoteDataSource evaluacionRespuestaRemoteDataSource;

  EvaluacionRespuestaRepositoryImpl(
      {required this.evaluacionRespuestaRemoteDataSource});

  @override
  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasRepository(UsuarioEntity usuario) async {
    try {
      final evaluacionesRespuestas = await evaluacionRespuestaRemoteDataSource
          .getEvaluacionesRespuestas(usuario);

      return Right(evaluacionesRespuestas);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      saveEvaluacionesRespuestasRepository(UsuarioEntity usuario,
          List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity) async {
    try {
      final result = await evaluacionRespuestaRemoteDataSource
          .saveEvaluacionesRespuestas(usuario, evaluacionesRespuestasEntity);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasNuevasRepository(
          UsuarioEntity usuario, List<EvaluacionEntity> evaluaciones) async {
    try {
      final evaluacionesRespuestas = await evaluacionRespuestaRemoteDataSource
          .getEvaluacionesRespuestasNuevas(usuario, evaluaciones);

      return Right(evaluacionesRespuestas);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
