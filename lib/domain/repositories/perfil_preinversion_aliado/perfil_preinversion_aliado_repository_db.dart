import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_aliado_entity.dart';

abstract class PerfilPreInversionAliadoRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      getPerfilPreInversionAliadosRepositoryDB(String perfilPreInversionId);

  Future<Either<Failure, List<PerfilPreInversionAliadoEntity>>>
      getPerfilesPreInversionesAliadosProduccionRepositoryDB();

  Future<Either<Failure, int>> savePerfilPreInversionAliadosRepositoryDB(
      List<PerfilPreInversionAliadoEntity> perfilPreInversionAliadoEntity);

  Future<Either<Failure, int>> savePerfilPreInversionAliadoRepositoryDB(
      PerfilPreInversionAliadoEntity perfilPreInversionAliadoEntity);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesAliadosProduccionDBRepositoryDB(
          List<PerfilPreInversionAliadoEntity>
              perfilesPreInversionesAliadosEntity);
}
