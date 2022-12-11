import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_precio_entity.dart';
import '../../repositories/perfil_preinversion_precio/perfil_preinversion_precio_repository_db.dart';

class PerfilPreInversionPrecioUsecaseDB {
  final PerfilPreInversionPrecioRepositoryDB repositoryDB;

  PerfilPreInversionPrecioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilPreInversionPreciosUsecaseDB() {
    return repositoryDB.getPerfilPreInversionPreciosRepositoryDB();
  }

  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilesPreInversionesPreciosUsecaseDB(String perfilPreInversionId) {
    return repositoryDB
        .getPerfilesPreInversionesPreciosRepositoryDB(perfilPreInversionId);
  }

  Future<Either<Failure, PerfilPreInversionPrecioEntity?>>
      getPerfilPreInversionPrecioUsecaseDB(String perfilPreInversionId) {
    return repositoryDB
        .getPerfilPreInversionPrecioRepositoryDB(perfilPreInversionId);
  }

  Future<Either<Failure, int>> savePerfilPreInversionPreciosUsecaseDB(
      List<PerfilPreInversionPrecioEntity> perfilPreInversionPreciosEntity) {
    return repositoryDB.savePerfilPreInversionPreciosRepositoryDB(
        perfilPreInversionPreciosEntity);
  }

  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilesPreInversionesPreciosProduccionUsecaseDB() {
    return repositoryDB
        .getPerfilesPreInversionesPreciosProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> savePerfilPreInversionPrecioUsecaseDB(
      PerfilPreInversionPrecioEntity perfilPreInversionPrecioEntity) {
    return repositoryDB.savePerfilPreInversionPrecioRepositoryDB(
        perfilPreInversionPrecioEntity);
  }

  Future<Either<Failure, int>> deletePerfilesPreInversionesPreciosUsecaseDB(
      String perfilPreInversionId, String productoId, String tipoCalidadId) {
    return repositoryDB.deletePerfilesPreInversionesPreciosRepositoryDB(
        perfilPreInversionId, productoId, tipoCalidadId);
  }

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesPreciosProduccionUsecaseDB(
          List<PerfilPreInversionPrecioEntity> experienciasAgricolasEntity) {
    return repositoryDB
        .updatePerfilesPreInversionesPreciosProduccionDBRepositoryDB(
            experienciasAgricolasEntity);
  }
}
