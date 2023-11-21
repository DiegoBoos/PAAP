import 'package:dartz/dartz.dart';
import '../../../data/core/error/failure.dart';
import '../../entities/perfil_preinversion_consultor_entity.dart';
import '../../repositories/perfil_preinversion_consultor/perfil_preinversion_consultor_repository_db.dart';

class PerfilPreInversionConsultorUsecaseDB {
  final PerfilPreInversionConsultorRepositoryDB repositoryDB;

  PerfilPreInversionConsultorUsecaseDB(this.repositoryDB);

  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>?>>
      getPerfilPreInversionConsultoresUsecaseDB(String perfilPreInversionId) {
    return repositoryDB
        .getPerfilPreInversionConsultoresRepositoryDB(perfilPreInversionId);
  }

  Future<Either<Failure, PerfilPreInversionConsultorEntity?>>
      getPerfilPreInversionConsultorUsecaseDB(
          String perfilPreInversionId, String consultorId, String revisionId) {
    return repositoryDB.getPerfilPreInversionConsultorRepositoryDB(
        perfilPreInversionId, consultorId, revisionId);
  }

  Future<Either<Failure, int>> savePerfilPreInversionConsultoresUsecaseDB(
      List<PerfilPreInversionConsultorEntity>
          perfilPreInversionConsultoresEntity) {
    return repositoryDB.savePerfilPreInversionConsultoresRepositoryDB(
        perfilPreInversionConsultoresEntity);
  }

  Future<Either<Failure, List<PerfilPreInversionConsultorEntity>>>
      getPerfilesPreInversionesConsultoresProduccionUsecaseDB() {
    return repositoryDB
        .getPerfilesPreInversionesConsultoresProduccionRepositoryDB();
  }

  Future<Either<Failure, int>> savePerfilPreInversionConsultorUsecaseDB(
      PerfilPreInversionConsultorEntity perfilPreInversionConsultorEntity) {
    return repositoryDB.savePerfilPreInversionConsultorRepositoryDB(
        perfilPreInversionConsultorEntity);
  }

  Future<Either<Failure, int>>
      updatePerfilesPreInversionesConsultoresProduccionUsecaseDB(
          List<PerfilPreInversionConsultorEntity>
              perfilPreInversionConsultorEntity) {
    return repositoryDB
        .updatePerfilesPreInversionesConsultoresProduccionDBRepositoryDB(
            perfilPreInversionConsultorEntity);
  }

  Future<Either<Failure, int>> deletePerfilesPreInversionesConsultoresUsecaseDB(
      String perfilPreInversionId, String consultorId, String revisionId) {
    return repositoryDB.deletePerfilesPreInversionesConsultoresRepositoryDB(
        perfilPreInversionId, consultorId, revisionId);
  }
}
