import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/evaluacion_entity.dart';
import '../../entities/evaluacion_respuesta_entity.dart';

abstract class EvaluacionRespuestaRepositoryDB {
  Future<Either<Failure, List<EvaluacionRespuestaEntity>?>>
      getEvaluacionesRespuestasRepositoryDB(
          String criterioId, String evaluacionId);

  Future<Either<Failure, EvaluacionRespuestaEntity?>>
      getEvaluacionRespuestaRepositoryDB(
          String criterioId, String evaluacionId);

  Future<Either<Failure, EvaluacionRespuestaEntity>>
      getEvaluacionRespuestaOpcionRepositoryDB(
          String criterioId, String evaluacionId, String opcionId);

  Future<Either<Failure, int>> saveEvaluacionRespuestaRepositoryDB(
      EvaluacionRespuestaEntity evaluacionRespuestaEntity, String perfilId);

  Future<Either<Failure, int>> saveEvaluacionesRespuestasRepositoryDB(
      List<EvaluacionRespuestaEntity> evaluacionRespuestaEntity);

  Future<Either<Failure, int>> clearEvaluacionesRespuestasRepositoryDB();

  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasProduccionRepositoryDB();

  Future<Either<Failure, int>>
      updateEvaluacionesRespuestasProduccionDBRepositoryDB(
          List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity);

  Future<Either<Failure, int>> updateRespuestaRemoteEvaluacionIdRepositoryDB(
      List<EvaluacionEntity> evaluaciones);
}
