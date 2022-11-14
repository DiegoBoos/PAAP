import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/evaluacion_respuesta_entity.dart';

abstract class EvaluacionRespuestaRepositoryDB {
  Future<Either<Failure, EvaluacionRespuestaEntity?>>
      getEvaluacionRespuestaRepositoryDB(
          String criterioId, String evaluacionId);

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
}
