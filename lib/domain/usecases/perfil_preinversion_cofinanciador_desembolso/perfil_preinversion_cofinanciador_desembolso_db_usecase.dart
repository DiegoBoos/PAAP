import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador_desembolso/perfil_preinversion_cofinanciador_desembolso_repository_db.dart';

class PerfilPreInversionCofinanciadorDesembolsoUsecaseDB {
  final PerfilPreInversionCofinanciadorDesembolsoRepositoryDB repositoryDB;

  PerfilPreInversionCofinanciadorDesembolsoUsecaseDB(this.repositoryDB);

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorDesembolsoEntity>?>>
      getPerfilPreInversionCofinanciadorDesembolsosUsecaseDB() {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorDesembolsosRepositoryDB();
  }

  Future<
          Either<Failure,
              List<PerfilPreInversionCofinanciadorDesembolsoEntity>?>>
      getPerfilPreInversionCofinanciadorDesembolsosByCofinanciadorUsecaseDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId) {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorDesembolsosByCofinanciadorRepositoryDB(
            perfilPreInversionId, cofinanciadorId, desembolsoId);
  }

  Future<Either<Failure, PerfilPreInversionCofinanciadorDesembolsoEntity?>>
      getPerfilPreInversionCofinanciadorDesembolsoUsecaseDB(
          String perfilPreInversionId,
          String cofinanciadorId,
          String desembolsoId) {
    return repositoryDB
        .getPerfilPreInversionCofinanciadorDesembolsoRepositoryDB(
            perfilPreInversionId, cofinanciadorId, desembolsoId);
  }

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorDesembolsosUsecaseDB(
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              perfilPreInversionCofinanciadorDesembolsosEntity) {
    return repositoryDB
        .savePerfilPreInversionCofinanciadorDesembolsosRepositoryDB(
            perfilPreInversionCofinanciadorDesembolsosEntity);
  }

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorDesembolsoEntity>>>
      getPerfilesPreInversionesCofinanciadoresDesembolsosProduccionUsecaseDB() {
    return repositoryDB
        .getPerfilesPreInversionesCofinanciadoresDesembolsosProduccionRepositoryDB();
  }

  Future<Either<Failure, int>>
      savePerfilPreInversionCofinanciadorDesembolsoUsecaseDB(
          PerfilPreInversionCofinanciadorDesembolsoEntity
              perfilPreInversionCofinanciadorDesembolsoEntity) {
    return repositoryDB
        .savePerfilPreInversionCofinanciadorDesembolsoRepositoryDB(
            perfilPreInversionCofinanciadorDesembolsoEntity);
  }

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccionUsecaseDB(
          List<PerfilPreInversionCofinanciadorDesembolsoEntity>
              experienciasAgricolasEntity) {
    return repositoryDB
        .updatePerfilesPreInversionesCofinanciadoresDesembolsosProduccionDBRepositoryDB(
            experienciasAgricolasEntity);
  }
}
