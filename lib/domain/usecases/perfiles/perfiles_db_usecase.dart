import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfiles_entity.dart';
import '../../repositories/perfiles/perfiles_repository_db.dart';

class PerfilesUsecaseDB {
  final PerfilesRepositoryDB repositoryDB;

  PerfilesUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesUsecaseDB() {
    return repositoryDB.getPerfilesRepositoryDB();
  }

  Future<Either<Failure, List<PerfilesEntity>>> getPerfilesFiltrosUsecaseDB(
      String? id, String? nombre) {
    return repositoryDB.getPerfilesFiltrosRepositoryDB(id ?? '', nombre ?? '');
  }

  /*  Future<Either<Failure, int>> savePerfilesDB(List<PerfilesEntity> perfiles) {
    return repositoryDB.savePerfilesRepositoryDB(perfiles);
  } */
}
