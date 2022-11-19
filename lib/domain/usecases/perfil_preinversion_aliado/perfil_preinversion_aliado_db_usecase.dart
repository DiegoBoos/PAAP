import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_aliado_entity.dart';
import '../../repositories/perfil_preinversion_aliado/perfil_preinversion_aliado_repository_db.dart';

class PerfilPreInversionAliadoUsecaseDB {
  final PerfilPreInversionAliadoRepositoryDB repositoryDB;

  PerfilPreInversionAliadoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>?>>
      getPerfilPreInversionAliadosUsecaseDB() {
    return repositoryDB.getPerfilPreInversionAliadosRepositoryDB();
  }

  Future<Either<Failure, PerfilPreInversionAliadoEntity?>>
      getPerfilPreInversionAliadoUsecaseDB(String id) {
    return repositoryDB.getPerfilPreInversionAliadoRepositoryDB(id);
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
