import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_precio_entity.dart';

abstract class PerfilPreInversionPrecioRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilPreInversionPreciosRepositoryDB();

  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilesPreInversionesPreciosRepositoryDB(String perfilPreInversionId);

  Future<Either<Failure, PerfilPreInversionPrecioEntity?>>
      getPerfilPreInversionPrecioRepositoryDB(String perfilPreInversionId);

  Future<Either<Failure, int>> savePerfilPreInversionPreciosRepositoryDB(
      List<PerfilPreInversionPrecioEntity> perfilPreInversionPrecioEntity);

  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilesPreInversionesPreciosProduccionRepositoryDB();

  Future<Either<Failure, int>> savePerfilPreInversionPrecioRepositoryDB(
      PerfilPreInversionPrecioEntity perfilPreInversionPrecioEntity);

  Future<Either<Failure, int>> deletePerfilesPreInversionesPreciosRepositoryDB(
      String perfilPreInversionId, String productoId, String tipoCalidadId);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesPreciosProduccionDBRepositoryDB(
          List<PerfilPreInversionPrecioEntity>
              perfilesPreInversionesPreciosEntity);
}
