import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/cofinanciador_entity.dart';
import '../../repositories/cofinanciador/cofinanciador_repository_db.dart';

class CofinanciadorUsecaseDB {
  final CofinanciadorRepositoryDB repositoryDB;

  CofinanciadorUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<CofinanciadorEntity>?>>
      getCofinanciadoresUsecaseDB() {
    return repositoryDB.getCofinanciadoresRepositoryDB();
  }

  Future<Either<Failure, CofinanciadorEntity?>> getCofinanciadorUsecaseDB(
      String id) {
    return repositoryDB.getCofinanciadorRepositoryDB(id);
  }

  Future<Either<Failure, int>> saveCofinanciadoresUsecaseDB(
      List<CofinanciadorEntity> cofinanciadorEntity) {
    return repositoryDB.saveCofinanciadoresRepositoryDB(cofinanciadorEntity);
  }
}
