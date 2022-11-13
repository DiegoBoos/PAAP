import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/visita_entity.dart';
import '../../repositories/visita/visita_repository_db.dart';

class VisitaUsecaseDB {
  final VisitaRepositoryDB repositoryDB;

  VisitaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, VisitaEntity>> getVisitaUsecaseDB(
      VisitaEntity visitaEntity) {
    return repositoryDB.getVisitaRepositoryDB(visitaEntity);
  }

  Future<Either<Failure, int>> saveVisitasUsecaseDB(
      List<VisitaEntity> visitasEntity) {
    return repositoryDB.saveVisitasRepositoryDB(visitasEntity);
  }

  Future<Either<Failure, int>> clearVisitasUsecaseDB() {
    return repositoryDB.clearVisitasRepositoryDB();
  }
}
