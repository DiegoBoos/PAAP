import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_plan_negocio_entity.dart';

abstract class PerfilPreInversionPlanNegocioRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilPreInversionplanesNegociosRepositoryDB();

  Future<Either<Failure, PerfilPreInversionPlanNegocioEntity?>>
      getPerfilPreInversionPlanNegocioRepositoryDB(
          String perfilPreInversionId, String rubroId, String year);

  Future<Either<Failure, int>> savePerfilPreInversionplanesNegociosRepositoryDB(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilPreInversionPlanNegocioEntity);

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilesPreInversionesplanesNegociosProduccionRepositoryDB();

  Future<Either<Failure, int>> savePerfilPreInversionPlanNegocioRepositoryDB(
      PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocioEntity);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesplanesNegociosProduccionDBRepositoryDB(
          List<PerfilPreInversionPlanNegocioEntity>
              perfilesPreInversionesplanesNegociosEntity);
}
