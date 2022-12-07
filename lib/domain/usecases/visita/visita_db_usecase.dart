import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/visita_entity.dart';
import '../../repositories/visita/visita_repository_db.dart';

class VisitaUsecaseDB {
  final VisitaRepositoryDB repositoryDB;

  VisitaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, VisitaEntity?>> getVisitaUsecaseDB(
      String perfilId, String tipoVisitaId) {
    return repositoryDB.getVisitaRepositoryDB(perfilId, tipoVisitaId);
  }

  Future<Either<Failure, VisitaEntity>> saveVisitaEvaluacionUsecaseDB(
      VisitaEntity visitaEntity) {
    return repositoryDB.saveVisitaEvaluacionRepositoryDB(visitaEntity);
  }

  Future<Either<Failure, int>> saveVisitasUsecaseDB(
      List<VisitaEntity> visitasEntity) {
    return repositoryDB.saveVisitasRepositoryDB(visitasEntity);
  }

  Future<Either<Failure, int>> clearVisitasUsecaseDB() {
    return repositoryDB.clearVisitasRepositoryDB();
  }

  Future<Either<Failure, List<VisitaEntity>>> getVisitasProduccionUsecaseDB() {
    return repositoryDB.getVisitasProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> updateVisitasProduccionUsecaseDB(
      List<VisitaEntity> visitasEntity) {
    return repositoryDB.updateVisitasProduccionDBRepositoryDB(visitasEntity);
  }
}
