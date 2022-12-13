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
          String perfilPreInversionId, String cofinanciadorId) {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorActividadesFinancierasByCofinanciadorRepositoryDB(
            perfilPreInversionId, cofinanciadorId);
  }

  Future<
          Either<Failure,
              PerfilPreInversionCofinanciadorActividadFinancieraEntity?>>
      getPerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB(
    String perfilPreInversionId,
    String cofinanciadorId,
  ) {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB(
      perfilPreInversionId,
      cofinanciadorId,
    );
  }

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorActividadesFinancierasUsecaseDB(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              perfilPreInversionCofinanciadorActividadesFinancierasEntity) {
    return repositoryDB
        .savePerfilPreInversionCofinanciadorActividadesFinancierasRepositoryDB(
            perfilPreInversionCofinanciadorActividadesFinancierasEntity);
  }

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>>>
      getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionUsecaseDB() {
    return repositoryDB
        .getPerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionRepositoryDB();
  }

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorActividadFinancieraUsecaseDB(
          PerfilPreInversionCofinanciadorActividadFinancieraEntity
              perfilPreInversionCofinanciadorActividadFinancieraEntity) {
    return repositoryDB
        .savePerfilPreInversionCofinanciadorActividadFinancieraRepositoryDB(
            perfilPreInversionCofinanciadorActividadFinancieraEntity);
  }

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionUsecaseDB(
          List<PerfilPreInversionCofinanciadorActividadFinancieraEntity>
              experienciasAgricolasEntity) {
    return repositoryDB
        .updatePerfilesPreInversionesCofinanciadoresActividadesFinancierasProduccionDBRepositoryDB(
            experienciasAgricolasEntity);
  }
}
