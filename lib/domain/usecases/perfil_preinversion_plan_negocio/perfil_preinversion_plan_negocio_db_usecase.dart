import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../entities/v_perfil_preinversion_plan_negocio_entity.dart';
import '../../repositories/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_repository_db.dart';

class PerfilPreInversionPlanNegocioUsecaseDB {
  final PerfilPreInversionPlanNegocioRepositoryDB repositoryDB;

  PerfilPreInversionPlanNegocioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>?>>
      getPerfilPreInversionPlanNegociosUsecaseDB() {
    return repositoryDB.getPerfilPreInversionPlanNegociosRepositoryDB();
  }

  Future<Either<Failure, List<VPerfilPreInversionPlanNegocioEntity>>>
      getVPerfilesPreInversionesPlanNegociosUsecaseDB(
          String perfilPreInversionId, String tipoMovimientoId) {
    return repositoryDB.getVPerfilesPreInversionesPlanNegociosRepositoryDB(
        perfilPreInversionId, tipoMovimientoId);
  }

  Future<Either<Failure, int>> savePerfilPreInversionPlanNegociosUsecaseDB(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilPreInversionPlanNegociosEntity) {
    return repositoryDB.savePerfilPreInversionPlanNegociosRepositoryDB(
        perfilPreInversionPlanNegociosEntity);
  }

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilesPreInversionesPlanNegociosProduccionUsecaseDB() {
    return repositoryDB
        .getPerfilesPreInversionesPlanNegociosProduccionRepositoryDB();
  }

  Future<Either<Failure, VPerfilPreInversionPlanNegocioEntity>>
      savePerfilPreInversionPlanNegocioUsecaseDB(
          PerfilPreInversionPlanNegocioEntity
              perfilPreInversionPlanNegocioEntity,
          String tipoMovimientoId) {
    return repositoryDB.savePerfilPreInversionPlanNegocioRepositoryDB(
        perfilPreInversionPlanNegocioEntity, tipoMovimientoId);
  }

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesPlanNegociosProduccionUsecaseDB(
          List<PerfilPreInversionPlanNegocioEntity>
              experienciasAgricolasEntity) {
    return repositoryDB
        .updatePerfilesPreInversionesPlanNegociosProduccionDBRepositoryDB(
            experienciasAgricolasEntity);
  }
}
