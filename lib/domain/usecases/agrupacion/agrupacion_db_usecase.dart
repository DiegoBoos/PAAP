import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/agrupacion_entity.dart';
import '../../repositories/agrupacion/agrupacion_repository_db.dart';

class AgrupacionUsecaseDB {
  final AgrupacionRepositoryDB repositoryDB;

  AgrupacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<AgrupacionEntity>?>> getAgrupacionesUsecaseDB() {
    return repositoryDB.getAgrupacionesRepositoryDB();
  }

  Future<Either<Failure, int>> saveAgrupacionesUsecaseDB(
      List<AgrupacionEntity> agrupacionEntity) {
    return repositoryDB.saveAgrupacionesRepositoryDB(agrupacionEntity);
  }
}
