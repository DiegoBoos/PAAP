import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/criterio_entity.dart';
import '../../repositories/criterio/criterio_repository_db.dart';

class CriterioUsecaseDB {
  final CriterioRepositoryDB repositoryDB;

  CriterioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<CriterioEntity>>> getCriteriosUsecaseDB(
      String agrupacionId) {
    return repositoryDB.getCriteriosRepositoryDB(agrupacionId);
  }

  Future<Either<Failure, int>> saveCriteriosUsecaseDB(
      List<CriterioEntity> criterioEntity) {
    return repositoryDB.saveCriteriosRepositoryDB(criterioEntity);
  }
}
