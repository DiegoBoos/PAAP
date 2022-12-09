import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../entities/v_perfil_preinversion_plan_negocio_entity.dart';

abstract class PerfilPreInversionPlanNegocioRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilPreInversionPlanesNegociosRepositoryDB();

  Future<Either<Failure, List<VPerfilPreInversionPlanNegocioEntity>>>
      getVPerfilesPreInversionesPlanNegociosRepositoryDB(
          String perfilPreInversionId, String tipoMovimientoId);

  Future<Either<Failure, int>> savePerfilPreInversionPlanesNegociosRepositoryDB(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilPreInversionPlanNegocioEntity);

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilesPreInversionesPlanesNegociosProduccionRepositoryDB();

  Future<Either<Failure, int>> savePerfilPreInversionPlanNegocioRepositoryDB(
      PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocioEntity);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesPlanesNegociosProduccionDBRepositoryDB(
          List<PerfilPreInversionPlanNegocioEntity>
              perfilesPreInversionesplanesNegociosEntity);
}
