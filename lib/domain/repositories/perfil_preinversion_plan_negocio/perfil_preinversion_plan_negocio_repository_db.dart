import 'package:dartz/dartz.dart';

import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../entities/v_perfil_preinversion_plan_negocio_entity.dart';

abstract class PerfilPreInversionPlanNegocioRepositoryDB {
  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilPreInversionPlanNegociosRepositoryDB();

  Future<Either<Failure, List<VPerfilPreInversionPlanNegocioEntity>>>
      getVPerfilesPreInversionesPlanNegociosRepositoryDB(
          String perfilPreInversionId, String tipoMovimientoId);

  Future<Either<Failure, int>> savePerfilPreInversionPlanNegociosRepositoryDB(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilPreInversionPlanNegocioEntity);

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilesPreInversionesPlanNegociosProduccionRepositoryDB();

  Future<Either<Failure, VPerfilPreInversionPlanNegocioEntity>>
      savePerfilPreInversionPlanNegocioRepositoryDB(
          PerfilPreInversionPlanNegocioEntity
              perfilPreInversionPlanNegocioEntity,
          String tipoMovimientoId);

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesPlanNegociosProduccionDBRepositoryDB(
          List<PerfilPreInversionPlanNegocioEntity>
              perfilesPreInversionesplanNegociosEntity);
}
