import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

import '../../entities/perfil_preinversion_entity.dart';
import '../../entities/v_perfil_preinversion_entity.dart';
import '../../repositories/perfil_preinversion/perfil_preinversion_repository_db.dart';

class PerfilPreinversionUsecaseDB {
  final PerfilPreinversionRepositoryDB repositoryDB;

  PerfilPreinversionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<VPerfilPreinversionEntity>>>
      getPerfilesPreinversionUsecaseDB() {
    return repositoryDB.getPerfilesPreinversionRepositoryDB();
  }

  Future<Either<Failure, List<VPerfilPreinversionEntity>>>
      getPerfilesPreinversionFiltrosUsecaseDB(String? id, String? nombre) {
    return repositoryDB.getPerfilesPreinversionFiltrosRepositoryDB(
        id ?? '', nombre ?? '');
  }

  Future<Either<Failure, int>> savePerfilesPreinversionUsecaseDB(
      List<PerfilPreinversionEntity> perfilesPreinversion) {
    return repositoryDB
        .savePerfilesPreinversionRepositoryDB(perfilesPreinversion);
  }
}
