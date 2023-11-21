import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_aliado_entity.dart';
import '../../repositories/perfil_preinversion_aliado/perfil_preinversion_aliado_repository_db.dart';

class PerfilPreInversionAliadoUsecaseDB {
  final PerfilPreInversionAliadoRepositoryDB repositoryDB;

  PerfilPreInversionAliadoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>?>>
      getPerfilPreInversionAliadosUsecaseDB(String perfilPreInversionId) {
    return repositoryDB
        .getPerfilPreInversionAliadosRepositoryDB(perfilPreInversionId);
  }

  Future<Either<Failure, int>> savePerfilPreInversionAliadosUsecaseDB(
      List<PerfilPreInversionAliadoEntity> perfilPreInversionAliadosEntity) {
    return repositoryDB.savePerfilPreInversionAliadosRepositoryDB(
        perfilPreInversionAliadosEntity);
  }

  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      getPerfilesPreInversionesAliadosProduccionUsecaseDB() {
    return repositoryDB
        .getPerfilesPreInversionesAliadosProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> savePerfilPreInversionAliadoUsecaseDB(
      PerfilPreInversionAliadoEntity perfilPreInversionAliadoEntity) {
    return repositoryDB.savePerfilPreInversionAliadoRepositoryDB(
        perfilPreInversionAliadoEntity);
  }

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesAliadosProduccionUsecaseDB(
          List<PerfilPreInversionAliadoEntity>
              perfilesPreInversionesAliadosEntity) {
    return repositoryDB
        .updatePerfilesPreInversionesAliadosProduccionDBRepositoryDB(
            perfilesPreInversionesAliadosEntity);
  }
}
