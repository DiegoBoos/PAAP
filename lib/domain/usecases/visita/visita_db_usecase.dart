import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/visita_entity.dart';
import '../../repositories/visita/visita_repository_db.dart';

class VisitaUsecaseDB {
  final VisitaRepositoryDB repositoryDB;

  VisitaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, VisitaEntity?>> getVisitaUsecaseDB(String id) {
    return repositoryDB.getVisitaRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveVisitaUsecaseDB(VisitaEntity visitaEntity) {
    return repositoryDB.saveVisitaRepositoryDB(visitaEntity);
  }

  Future<Either<Failure, int>> clearVisitasUsecaseDB() {
    return repositoryDB.clearVisitasRepositoryDB();
  }
}
