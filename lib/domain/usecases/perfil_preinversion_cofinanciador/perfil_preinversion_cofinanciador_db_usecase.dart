import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../entities/perfil_preinversion_cofinanciador_entity.dart';
import '../../repositories/perfil_preinversion_cofinanciador/perfil_preinversion_cofinanciador_repository_db.dart';

class PerfilPreInversionCofinanciadorUsecaseDB {
  final PerfilPreInversionCofinanciadorRepositoryDB repositoryDB;

  PerfilPreInversionCofinanciadorUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>?>>
      getPerfilPreInversionCofinanciadoresUsecaseDB(
          String perfilPreInversionId) {
    //TODO: perfilPreInversionId
    return repositoryDB.getPerfilPreInversionCofinanciadoresRepositoryDB();
  }

  Future<Either<Failure, int>>
      savePerfilesPreInversionesCofinanciadoresUsecaseDB(
          List<PerfilPreInversionCofinanciadorEntity>
              perfilPreInversionCofinanciadoresEntity) {
    return repositoryDB.savePerfilesPreInversionesCofinanciadoresRepositoryDB(
        perfilPreInversionCofinanciadoresEntity);
  }

  Future<Either<Failure, List<PerfilPreInversionCofinanciadorEntity>>>
      getPerfilesPreInversionesCofinanciadoresProduccionUsecaseDB() {
    return repositoryDB
        .getPerfilesPreInversionesCofinanciadoresProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> savePerfilPreInversionCofinanciadorUsecaseDB(
      PerfilPreInversionCofinanciadorEntity
          perfilPreInversionCofinanciadorEntity) {
    return repositoryDB.savePerfilPreInversionCofinanciadorRepositoryDB(
        perfilPreInversionCofinanciadorEntity);
  }

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesCofinanciadoresProduccionUsecaseDB(
          List<PerfilPreInversionCofinanciadorEntity>
              experienciasAgricolasEntity) {
    return repositoryDB
        .updatePerfilesPreInversionesCofinanciadoresProduccionDBRepositoryDB(
            experienciasAgricolasEntity);
  }
}
