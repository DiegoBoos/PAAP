import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/evaluacion_entity.dart';
import '../../repositories/evaluacion/evaluacion_repository_db.dart';

class EvaluacionUsecaseDB {
  final EvaluacionRepositoryDB repositoryDB;

  EvaluacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, EvaluacionEntity?>> getEvaluacionUsecaseDB(
      String perfilId) {
    return repositoryDB.getEvaluacionRepositoryDB(perfilId);
  }

  Future<Either<Failure, int>> saveEvaluacionUsecaseDB(
      EvaluacionEntity evaluacionEntity) {
    return repositoryDB.saveEvaluacionRepositoryDB(evaluacionEntity);
  }

  Future<Either<Failure, int>> saveEvaluacionesUsecaseDB(
      List<EvaluacionEntity> evaluacionesEntity) {
    return repositoryDB.saveEvaluacionesRepositoryDB(evaluacionesEntity);
  }

/*   Future<Either<Failure, int>> saveEvaluacionesUsecaseDB(
      List<EvaluacionEntity> evaluacionEntity) {
    return repositoryDB.saveEvaluacionesRepositoryDB(evaluacionEntity);
  } */

  Future<Either<Failure, int>> clearEvaluacionesUsecaseDB() {
    return repositoryDB.clearEvaluacionesRepositoryDB();
  }

  Future<Either<Failure, List<EvaluacionEntity>>>
      getEvaluacionesProduccionUsecaseDB() {
    return repositoryDB.getEvaluacionesProduccionRepositoryDB();
  }

  Future<Either<Failure, List<String>>> updateEvaluacionesProduccionUsecaseDB(
      List<EvaluacionEntity> evaluacionesEntity) {
    return repositoryDB
        .updateEvaluacionesProduccionDBRepositoryDB(evaluacionesEntity);
  }
}
