import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_plan_negocio_entity.dart';
import '../../repositories/perfil_preinversion_plan_negocio/perfil_preinversion_plan_negocio_repository_db.dart';

class PerfilPreInversionPlanNegocioUsecaseDB {
  final PerfilPreInversionPlanNegocioRepositoryDB repositoryDB;

  PerfilPreInversionPlanNegocioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>?>>
      getPerfilPreInversionPlanesNegociosUsecaseDB() {
    return repositoryDB.getPerfilPreInversionPlanesNegociosRepositoryDB();
  }

  Future<Either<Failure, PerfilPreInversionPlanNegocioEntity?>>
      getPerfilPreInversionPlanNegocioUsecaseDB(
          String perfilPreInversionId, String rubroId, String year) {
    return repositoryDB.getPerfilPreInversionPlanNegocioRepositoryDB(
        perfilPreInversionId, rubroId, year);
  }

  Future<Either<Failure, int>> savePerfilPreInversionPlanesNegociosUsecaseDB(
      List<PerfilPreInversionPlanNegocioEntity>
          perfilPreInversionPlanesNegociosEntity) {
    return repositoryDB.savePerfilPreInversionPlanesNegociosRepositoryDB(
        perfilPreInversionPlanesNegociosEntity);
  }

  Future<Either<Failure, List<PerfilPreInversionPlanNegocioEntity>>>
      getPerfilesPreInversionesPlanesNegociosProduccionUsecaseDB() {
    return repositoryDB
        .getPerfilesPreInversionesPlanesNegociosProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> savePerfilPreInversionPlanNegocioUsecaseDB(
      PerfilPreInversionPlanNegocioEntity perfilPreInversionPlanNegocioEntity) {
    return repositoryDB.savePerfilPreInversionPlanNegocioRepositoryDB(
        perfilPreInversionPlanNegocioEntity);
  }

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesPlanesNegociosProduccionUsecaseDB(
          List<PerfilPreInversionPlanNegocioEntity>
              experienciasAgricolasEntity) {
    return repositoryDB
        .updatePerfilesPreInversionesPlanesNegociosProduccionDBRepositoryDB(
            experienciasAgricolasEntity);
  }
}
