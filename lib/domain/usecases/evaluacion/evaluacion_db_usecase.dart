import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/evaluacion_entity.dart';
import '../../repositories/evaluacion/evaluacion_repository_db.dart';

class EvaluacionUsecaseDB {
  final EvaluacionRepositoryDB repositoryDB;

  EvaluacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, EvaluacionEntity?>> getEvaluacionUsecaseDB(String id) {
    return repositoryDB.getEvaluacionRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveEvaluacionUsecaseDB(
      EvaluacionEntity evaluacionEntity) {
    return repositoryDB.saveEvaluacionRepositoryDB(evaluacionEntity);
  }

  Future<Either<Failure, int>> saveEvaluacionesUsecaseDB(
      List<EvaluacionEntity> evaluacionEntity) {
    return repositoryDB.saveEvaluacionesRepositoryDB(evaluacionEntity);
  }

  Future<Either<Failure, int>> clearEvaluacionesUsecaseDB() {
    return repositoryDB.clearEvaluacionesRepositoryDB();
  }
}
