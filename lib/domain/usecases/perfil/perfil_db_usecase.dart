import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_entity.dart';

import '../../entities/v_perfil_entity.dart';
import '../../repositories/perfil/perfil_repository_db.dart';

class PerfilUsecaseDB {
  final PerfilRepositoryDB repositoryDB;

  PerfilUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<VPerfilEntity>>> getPerfilesUsecaseDB() {
    return repositoryDB.getPerfilesRepositoryDB();
  }

  Future<Either<Failure, List<VPerfilEntity>>> getPerfilesFiltrosUsecaseDB(
      String? id, String? nombre) {
    return repositoryDB.getPerfilesFiltrosRepositoryDB(id ?? '', nombre ?? '');
  }

  Future<Either<Failure, int>> savePerfilesUsecaseDB(
      List<PerfilEntity> perfiles) {
    return repositoryDB.savePerfilesRepositoryDB(perfiles);
  }

  Future<Either<Failure, List<String>>> getMunicipiosPerfilesUsecaseDB() {
    return repositoryDB.getMunicipiosPerfilesRepositoryDB();
  }
}
