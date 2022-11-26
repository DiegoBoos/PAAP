import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_rubro_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador_rubro/perfil_preinversion_cofinanciador_rubro_repository_db.dart';

class PerfilPreInversionCofinanciadorRubroUsecaseDB {
  final PerfilPreInversionCofinanciadorRubroRepositoryDB repositoryDB;

  PerfilPreInversionCofinanciadorRubroUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>?>>
      getPerfilPreInversionCofinanciadorRubrosUsecaseDB() {
    return repositoryDB.getPerfilPreInversionCofinanciadorRubrosRepositoryDB();
  }

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>?>>
      getPerfilPreInversionCofinanciadorRubrosByCofinanciadorUsecaseDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId,
          String actividadFinancieraId,
          String rubroId) {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorRubrosByCofinanciadorRepositoryDB(
            perfilPreInversionId,
            cofinanciadorId,
            desembolsoId,
            actividadFinancieraId,
            rubroId);
  }

  Future<Either<Failure, PerfilPreInversionCofinanciadorRubroEntity?>>
      getPerfilPreInversionCofinanciadorRubroUsecaseDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId,
          String actividadFinancieraId,
          String rubroId) {
    return repositoryDB.getPerfilPreInversionCofinanciadorRubroRepositoryDB(
        perfilPreInversionId,
        cofinanciadorId,
        desembolsoId,
        actividadFinancieraId,
        rubroId);
  }

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorRubrosUsecaseDB(
          List<PerfilPreInversionCofinanciadorRubroEntity>
              perfilPreInversionCofinanciadorRubrosEntity) {
    return repositoryDB.savePerfilPreInversionCofinanciadorRubrosRepositoryDB(
        perfilPreInversionCofinanciadorRubrosEntity);
  }

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorRubroEntity>>>
      getPerfilesPreInversionesCofinanciadoresRubrosProduccionUsecaseDB() {
    return repositoryDB
        .getPerfilesPreInversionesCofinanciadoresRubrosProduccionRepositoryDB();
  }

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorRubroUsecaseDB(
          PerfilPreInversionCofinanciadorRubroEntity
              perfilPreInversionCofinanciadorRubroEntity) {
    return repositoryDB.savePerfilPreInversionCofinanciadorRubroRepositoryDB(
        perfilPreInversionCofinanciadorRubroEntity);
  }

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresRubrosProduccionUsecaseDB(
          List<PerfilPreInversionCofinanciadorRubroEntity>
              experienciasAgricolasEntity) {
    return repositoryDB
        .updatePerfilesPreInversionesCofinanciadoresRubrosProduccionDBRepositoryDB(
            experienciasAgricolasEntity);
  }
}
