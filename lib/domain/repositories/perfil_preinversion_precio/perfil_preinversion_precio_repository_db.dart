import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_precio_entity.dart';

abstract class PerfilPreInversionPrecioRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionPrecioEntity>>>
      getPerfilPreInversionPreciosRepositoryDB();

  Future<Either<Failure, PerfilPreInversionPrecioEntity?>>
      getPerfilPreInversionPrecioRepositoryDB(String id);

  Future<Either<Failure, int>> savePerfilPreInversionPreciosRepositoryDB(
      List<PerfilPreInversionPrecioEntity> perfilPreInversionPrecioEntity);
}
