import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_precio_entity.dart';
import '../../repositories/perfil_preinversion_precio/perfil_preinversion_precio_repository_db.dart';

class PerfilPreInversionPrecioUsecaseDB {
  final PerfilPreInversionPrecioRepositoryDB repositoryDB;

  PerfilPreInversionPrecioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>?>>
      getPerfilPreInversionPreciosUsecaseDB() {
    return repositoryDB.getPerfilPreInversionPreciosRepositoryDB();
  }

  Future<Either<Failure, PerfilPreInversionPrecioEntity?>>
      getPerfilPreInversionPrecioUsecaseDB(String id) {
    return repositoryDB.getPerfilPreInversionPrecioRepositoryDB(id);
  }

  Future<Either<Failure, int>> savePerfilPreInversionPreciosUsecaseDB(
      List<PerfilPreInversionPrecioEntity> perfilPreInversionPreciosEntity) {
    return repositoryDB.savePerfilPreInversionPreciosRepositoryDB(
        perfilPreInversionPreciosEntity);
  }
}
