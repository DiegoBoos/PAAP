import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

import '../../entities/perfil_preinversion_entity.dart';
import '../../entities/v_perfil_preinversion_entity.dart';
import '../../repositories/perfil_preinversion/perfil_preinversion_repository_db.dart';

class PerfilPreInversionUsecaseDB {
  final PerfilPreInversionRepositoryDB repositoryDB;

  PerfilPreInversionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<VPerfilPreInversionEntity>>>
      getPerfilesPreInversionUsecaseDB() {
    return repositoryDB.getPerfilesPreInversionRepositoryDB();
  }

  Future<Either<Failure, List<VPerfilPreInversionEntity>>>
      getPerfilesPreInversionFiltrosUsecaseDB(String? id, String? nombre) {
    return repositoryDB.getPerfilesPreInversionFiltrosRepositoryDB(
        id ?? '', nombre ?? '');
  }

  Future<Either<Failure, int>> savePerfilesPreInversionUsecaseDB(
      List<PerfilPreInversionEntity> perfilesPreInversion) {
    return repositoryDB
        .savePerfilesPreInversionRepositoryDB(perfilesPreInversion);
  }

  Future<Either<Failure, PerfilPreInversionEntity?>>
      getPerfilPreInversionUsecaseDB(String id) {
    return repositoryDB.getPerfilPreInversionRepositoryDB(id);
  }
}
