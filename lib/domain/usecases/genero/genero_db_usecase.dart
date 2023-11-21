import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/genero_entity.dart';
import '../../repositories/genero/genero_repository_db.dart';

class GeneroUsecaseDB {
  final GeneroRepositoryDB repositoryDB;

  GeneroUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<GeneroEntity>?>> getGenerosUsecaseDB() {
    return repositoryDB.getGenerosRepositoryDB();
  }

  Future<Either<Failure, int>> saveGenerosUsecaseDB(
      List<GeneroEntity> generoEntity) {
    return repositoryDB.saveGenerosRepositoryDB(generoEntity);
  }
}
