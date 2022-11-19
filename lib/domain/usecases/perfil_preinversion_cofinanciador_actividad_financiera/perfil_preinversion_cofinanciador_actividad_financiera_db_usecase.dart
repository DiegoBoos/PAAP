import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador_actividad_financiera/perfil_preinversion_cofinanciador_actividad_financiera_repository_db.dart';

class PerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB {
  final PerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB
      repositoryDB;

  PerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB(
      this.repositoryDB);

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>?>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasUsecaseDB() {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorActividadesFinancierasRepositoryDB();
  }

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>?>>
      getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciadorUsecaseDB(
          String cofinanciadorId) {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciadorRepositoryDB(
            cofinanciadorId);
  }

  Future<
          Either<Failure,
              PerfilPreInversionCofinanciadorActividadFinancieraEntity?>>
      getPerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB(
          String id) {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB(id);
  }

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorActividadesFinancierasUsecaseDB(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilPreInversionCofinanciadorActividadesFinancierasEntity) {
    return repositoryDB
        .savePerfilPreInversionCofinanciadorActividadesFinancierasRepositoryDB(
            perfilPreInversionCofinanciadorActividadesFinancierasEntity);
  }
}
