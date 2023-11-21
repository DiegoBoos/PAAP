import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/departamento_entity.dart';
import '../../repositories/departamento/departamento_repository_db.dart';

class DepartamentoUsecaseDB {
  final DepartamentoRepositoryDB repositoryDB;

  DepartamentoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<DepartamentoEntity>?>>
      getDepartamentosUsecaseDB() {
    return repositoryDB.getDepartamentosRepositoryDB();
  }

  Future<Either<Failure, int>> saveDepartamentosUsecaseDB(
      List<DepartamentoEntity> departamentoEntity) {
    return repositoryDB.saveDepartamentosRepositoryDB(departamentoEntity);
  }
}
