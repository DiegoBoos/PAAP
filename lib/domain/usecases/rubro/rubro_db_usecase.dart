import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/rubro_entity.dart';
import '../../repositories/rubro/rubro_repository_db.dart';

class RubroUsecaseDB {
  final RubroRepositoryDB repositoryDB;

  RubroUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<RubroEntity>?>> getRubrosUsecaseDB() {
    return repositoryDB.getRubrosRepositoryDB();
  }

  Future<Either<Failure, int>> saveRubrosUsecaseDB(
      List<RubroEntity> rubroEntity) {
    return repositoryDB.saveRubrosRepositoryDB(rubroEntity);
  }
}
