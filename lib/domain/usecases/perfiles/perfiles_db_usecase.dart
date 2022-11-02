import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_entity.dart';

import '../../entities/vperfil_entity.dart';
import '../../repositories/perfiles/perfiles_repository_db.dart';

class PerfilesUsecaseDB {
  final PerfilesRepositoryDB repositoryDB;

  PerfilesUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilEntity>>> getPerfilesUsecaseDB() {
    return repositoryDB.getPerfilesRepositoryDB();
  }

  Future<Either<Failure, List<PerfilEntity>>> getPerfilesFiltrosUsecaseDB(
      String? id, String? nombre) {
    return repositoryDB.getPerfilesFiltrosRepositoryDB(id ?? '', nombre ?? '');
  }

  Future<Either<Failure, int>> savePerfilesUsecaseDB(
      List<PerfilEntity> perfiles) {
    return repositoryDB.savePerfilesRepositoryDB(perfiles);
  }

  Future<Either<Failure, VPerfilEntity?>> getPerfilUsecaseDB(String id) {
    return repositoryDB.getPerfilRepositoryDB(id);
  }
}
