import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/evaluacion_respuesta_entity.dart';
import '../../repositories/evaluacion_respuesta/evaluacion_respuesta_repository_db.dart';

class EvaluacionRespuestaUsecaseDB {
  final EvaluacionRespuestaRepositoryDB repositoryDB;

  EvaluacionRespuestaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, EvaluacionRespuestaEntity?>>
      getEvaluacionRespuestaUsecaseDB(String criterioId, String evaluacionId) {
    return repositoryDB.getEvaluacionRespuestaRepositoryDB(
        criterioId, evaluacionId);
  }

  Future<Either<Failure, int>> saveEvaluacionRespuestaUsecaseDB(
      EvaluacionRespuestaEntity evaluacionRespuestaEntity, String perfilId) {
    return repositoryDB.saveEvaluacionRespuestaRepositoryDB(
        evaluacionRespuestaEntity, perfilId);
  }

  /* Future<Either<Failure, int>> saveEvaluacionesRespuestasUsecaseDB(
      List<EvaluacionRespuestaEntity> evaluacionRespuestaEntity) {
    return repositoryDB
        .saveEvaluacionesRespuestasRepositoryDB(evaluacionRespuestaEntity);
  } */

  Future<Either<Failure, int>> saveEvaluacionesRespuestasUsecaseDB(
      List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity) {
    return repositoryDB
        .saveEvaluacionesRespuestasRepositoryDB(evaluacionesRespuestasEntity);
  }

  Future<Either<Failure, int>> clearEvaluacionesRespuestasUsecaseDB() {
    return repositoryDB.clearEvaluacionesRespuestasRepositoryDB();
  }

  Future<Either<Failure, List<EvaluacionRespuestaEntity>>>
      getEvaluacionesRespuestasProduccionUsecaseDB() {
    return repositoryDB.getEvaluacionesRespuestasProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> updateEvaluacionesRespuestasProduccionUsecaseDB(
      List<EvaluacionRespuestaEntity> evaluacionesRespuestasEntity) {
    return repositoryDB.updateEvaluacionesRespuestasProduccionDBRepositoryDB(
        evaluacionesRespuestasEntity);
  }
}
